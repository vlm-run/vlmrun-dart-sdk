import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../vlmrun_client.dart';
import '../types/files.dart';
import '../types/presigned_url.dart';
import '../utils/http_utils.dart';

/// Resource class for file-related endpoints.
class FilesResource {
  FilesResource(this._client);

  final VlmRun _client;

  /// Create a file.
  Future<FileResponse> create({
    required File file,
    String? purpose,
  }) async {
    final fields = <String, String>{};
    if (purpose != null) {
      fields['purpose'] = purpose;
    }

    final multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: path.basename(file.path),
    );

    final response = await _client.multipartRequest(
      'POST',
      '/v1/files',
      file: multipartFile,
      fields: fields,
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    print(json);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        json,
      );
    }

    return FileResponse.fromJson(json);
  }

  /// List files.
  Future<List<FileResponse>> list({
    String? purpose,
    int? limit,
    String? after,
    String? order,
  }) async {
    final params = FileListRequest(
      purpose: purpose,
      limit: limit,
      after: after,
      order: order,
    );

    var path = '/v1/files';
    final queryParams = params.toJson().map(
          (key, value) => MapEntry(key, value.toString()),
        );

    final url = Uri.parse(path).replace(queryParameters: queryParams);
    path = url.toString();

    final response = await _client.request('GET', path);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return json
        .map((item) => FileResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<FileResponse> retrieve(String fileId,
      {bool? generatePublicUrl}) async {
    var path = '/v1/files/$fileId';
    if (generatePublicUrl != null) {
      final uri = Uri.parse(path).replace(queryParameters: {
        'generate_public_url': generatePublicUrl.toString(),
      });
      path = uri.toString();
    }

    final response = await _client.request('GET', path);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    return FileResponse.fromJson(json);
  }

  /// Delete a file.
  Future<void> delete(String fileId) async {
    if (fileId.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `fileId`');
    }

    final response = await _client.request('DELETE', '/v1/files/$fileId');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
  }

  /// Generate a presigned URL for file upload.
  Future<PresignedUrlResponse> generatePresignedUrl({
    required String filename,
    String? purpose,
  }) async {
    final data = <String, dynamic>{
      'filename': filename,
    };
    if (purpose != null) data['purpose'] = purpose;

    final response = await _client.request(
      'POST',
      '/v1/files/presigned-url',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PresignedUrlResponse.fromJson(json);
  }
}
