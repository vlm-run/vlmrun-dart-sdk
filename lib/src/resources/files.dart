import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../vlm_client.dart';
import '../types/files.dart';
import '../utils/http_utils.dart';

/// Resource class for file-related endpoints.
class FilesResource {
  FilesResource(this._client);

  final Vlm _client;

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

  Future<FileResponse> retrieve(String fileId) async {
    final response = await _client.request('GET', '/v1/files/$fileId');
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    return FileResponse.fromJson(json);
  }
}
