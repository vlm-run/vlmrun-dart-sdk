import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/dataset.dart';
import '../utils/http_utils.dart';

/// Resource class for dataset-related endpoints.
class DatasetsResource {
  DatasetsResource(this._client);

  final VlmRun _client;

  /// Create a dataset.
  ///
  /// [fileId] - The uploaded file ID (e.g., tar.gz archive)
  /// [domain] - Domain for the dataset
  /// [datasetName] - Name of the dataset
  /// [datasetType] - Type of dataset (images, videos, or documents)
  /// [wandbBaseUrl] - Base URL for Weights & Biases
  /// [wandbProjectName] - Project name for Weights & Biases
  /// [wandbApiKey] - API key for Weights & Biases
  Future<DatasetResponse> create({
    required String fileId,
    required String domain,
    required String datasetName,
    required String datasetType,
    String? wandbBaseUrl,
    String? wandbProjectName,
    String? wandbApiKey,
  }) async {
    final data = <String, dynamic>{
      'file_id': fileId,
      'domain': domain,
      'dataset_name': datasetName,
      'dataset_type': datasetType,
    };
    if (wandbBaseUrl != null) data['wandb_base_url'] = wandbBaseUrl;
    if (wandbProjectName != null) {
      data['wandb_project_name'] = wandbProjectName;
    }
    if (wandbApiKey != null) data['wandb_api_key'] = wandbApiKey;

    final response = await _client.request(
      'POST',
      '/v1/datasets/create',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return DatasetResponse.fromJson(json);
  }

  /// Get dataset information by ID.
  Future<DatasetResponse> get(String datasetId) async {
    if (datasetId.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `datasetId`');
    }

    final response = await _client.request('GET', '/v1/datasets/$datasetId');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return DatasetResponse.fromJson(json);
  }

  /// List all datasets.
  Future<List<DatasetResponse>> list({
    int? skip,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (skip != null) queryParams['skip'] = skip.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    var path = '/v1/datasets';
    if (queryParams.isNotEmpty) {
      final uri = Uri.parse(path).replace(queryParameters: queryParams);
      path = uri.toString();
    }

    final response = await _client.request('GET', path);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => DatasetResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
