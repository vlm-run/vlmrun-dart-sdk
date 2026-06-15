import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../vlmrun_client.dart';
import '../utils/http_utils.dart';

/// Extension and content-type mappings for file-based artifacts.
const _extMapping = <String, String>{
  'vid': 'mp4',
  'aud': 'mp3',
  'doc': 'pdf',
  'recon': 'spz',
};

const _contentTypeMapping = <String, String>{
  'vid': 'video/mp4',
  'aud': 'audio/mpeg',
  'doc': 'application/pdf',
  'recon': 'application/octet-stream',
};

/// Response type for artifacts - either raw bytes or a file path.
sealed class ArtifactResponse {
  const ArtifactResponse();
}

/// Artifact response containing raw bytes (e.g., for images).
class ArtifactBytesResponse extends ArtifactResponse {
  const ArtifactBytesResponse(this.bytes);

  final Uint8List bytes;
}

/// Artifact response containing a file path.
class ArtifactFileResponse extends ArtifactResponse {
  const ArtifactFileResponse(this.filePath);

  final String filePath;
}

/// Parameters for getting an artifact.
class ArtifactGetParams {
  const ArtifactGetParams({
    required this.objectId,
    this.sessionId,
    this.executionId,
    this.rawResponse = false,
  });

  /// Object ID for the artifact (format: <type>_<6-hex-chars>).
  final String objectId;

  /// Session ID for the artifact (mutually exclusive with executionId).
  final String? sessionId;

  /// Execution ID for the artifact (mutually exclusive with sessionId).
  final String? executionId;

  /// Whether to return the raw response as bytes (default: false).
  final bool rawResponse;
}

/// Resource class for artifact-related endpoints.
class ArtifactsResource {
  ArtifactsResource(this._client);

  final VlmRun _client;

  /// Get the artifacts directory path for a session/execution.
  String _getArtifactsDir(String sessionId) {
    final homeDir = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        '.';
    return path.join(homeDir, '.vlmrun', 'artifacts', sessionId);
  }

  /// Ensure the artifacts directory exists.
  Directory _ensureArtifactsDir(String sessionId) {
    final artifactsDir = Directory(_getArtifactsDir(sessionId));
    if (!artifactsDir.existsSync()) {
      artifactsDir.createSync(recursive: true);
    }
    return artifactsDir;
  }

  /// Get an artifact by session ID or execution ID and object ID.
  ///
  /// Supported artifact types:
  ///   - img: Returns [ArtifactBytesResponse] (JPEG image data)
  ///   - url: Returns [ArtifactFileResponse] (downloads file from URL)
  ///   - vid: Returns [ArtifactFileResponse] path to MP4 file
  ///   - aud: Returns [ArtifactFileResponse] path to MP3 file
  ///   - doc: Returns [ArtifactFileResponse] path to PDF file
  ///   - recon: Returns [ArtifactFileResponse] path to SPZ file
  ///
  /// Parameters:
  ///   - [params.objectId] - Object ID for the artifact (format: <type>_<6-hex-chars>)
  ///   - [params.sessionId] - Session ID for the artifact (mutually exclusive with executionId)
  ///   - [params.executionId] - Execution ID for the artifact (mutually exclusive with sessionId)
  ///   - [params.rawResponse] - Whether to return the raw response as bytes (default: false)
  ///
  /// Returns the artifact content - type depends on objectId prefix and rawResponse flag.
  ///
  /// Throws [ArgumentError] if neither sessionId nor executionId is provided,
  /// or if both are provided.
  Future<ArtifactResponse> get(ArtifactGetParams params) async {
    final objectId = params.objectId;
    final sessionId = params.sessionId;
    final executionId = params.executionId;
    final rawResponse = params.rawResponse;

    // Validate that exactly one of sessionId or executionId is provided
    if (sessionId == null && executionId == null) {
      throw ArgumentError('Either `sessionId` or `executionId` is required');
    }
    if (sessionId != null && executionId != null) {
      throw ArgumentError(
        'Only one of `sessionId` or `executionId` is allowed, not both',
      );
    }

    // Build query parameters
    final queryParams = <String, String>{
      'object_id': objectId,
    };
    if (sessionId != null) {
      queryParams['session_id'] = sessionId;
    }
    if (executionId != null) {
      queryParams['execution_id'] = executionId;
    }

    // Make request
    final response = await _client.requestBytes(
      'GET',
      '/v1/artifacts',
      queryParams: queryParams,
    );

    final data = response.bodyBytes;
    final headers = response.headers;

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        {'error': 'Failed to get artifact', 'status': response.statusCode},
      );
    }

    if (rawResponse) {
      return ArtifactBytesResponse(data);
    }

    // Validate object ID format
    final parts = objectId.split('_');
    if (parts.length < 2) {
      throw ArgumentError(
        'Invalid object ID: $objectId, expected format: <obj_type>_<6-digit-hex-string>',
      );
    }

    // Handle special case for 'recon' which has format 'recon_XXXXXX'
    final objType = parts[0] == 'recon' ? 'recon' : parts[0];
    final objIdSuffix = parts[parts.length - 1];

    if (objIdSuffix.length != 6) {
      throw ArgumentError(
        'Invalid object ID: $objectId, expected format: <obj_type>_<6-digit-hex-string>',
      );
    }

    // Get session/execution ID for artifacts directory
    final sessId = sessionId ?? executionId!;
    final artifactsDir = _ensureArtifactsDir(sessId);

    if (objType == 'img') {
      final contentType = headers['content-type'];
      if (contentType != null && contentType != 'image/jpeg') {
        throw StateError('Expected image/jpeg, got $contentType');
      }
      return ArtifactBytesResponse(data);
    } else if (objType == 'url') {
      // URL artifact - decode the URL and download the file
      final url = String.fromCharCodes(data);

      // Extract filename from URL, stripping query parameters
      final uri = Uri.parse(url);
      final urlPath = uri.path;
      var filename = path.basename(urlPath).split('?')[0];
      final ext = filename.split('.').last.toLowerCase();
      final tmpPath = path.join(artifactsDir.path, '$filename.$ext');

      // Return cached version if it exists
      final cachedFile = File(tmpPath);
      if (cachedFile.existsSync()) {
        return ArtifactFileResponse(tmpPath);
      }

      // Download the file
      final fileResponse = await http.get(uri);
      if (!HttpUtils.isSuccessful(fileResponse.statusCode)) {
        throw StateError('Failed to download file from URL: $url');
      }
      await cachedFile.writeAsBytes(fileResponse.bodyBytes);
      return ArtifactFileResponse(tmpPath);
    } else if (['vid', 'aud', 'doc', 'recon'].contains(objType)) {
      // Validate content type
      final expectedContentType = _contentTypeMapping[objType];
      final actualContentType = headers['content-type'];
      if (actualContentType != null &&
          actualContentType != expectedContentType) {
        throw StateError(
            'Expected $expectedContentType, got $actualContentType');
      }

      // Build file path with appropriate extension
      final ext = _extMapping[objType];
      if (ext == null) {
        throw StateError(
          'Unsupported file type [file_type=$objType, object_id=$objectId]',
        );
      }
      final tmpPath = path.join(artifactsDir.path, '$objectId.$ext');

      // Return cached version if it exists
      final cachedFile = File(tmpPath);
      if (cachedFile.existsSync()) {
        return ArtifactFileResponse(tmpPath);
      }

      // Write the binary response to file
      await cachedFile.writeAsBytes(data);
      return ArtifactFileResponse(tmpPath);
    } else {
      // Unknown type - return raw bytes
      return ArtifactBytesResponse(data);
    }
  }

  /// List artifacts for a session.
  ///
  /// Throws [UnimplementedError] - This method is not yet implemented.
  Future<void> list(String sessionId) async {
    throw UnimplementedError('Artifacts.list() is not yet implemented');
  }
}
