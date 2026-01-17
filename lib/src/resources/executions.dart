import 'dart:convert';

import '../vlm_client.dart';
import '../types/agent.dart';
import '../utils/http_utils.dart';
import 'predictions.dart';

/// Resource class for execution-related endpoints.
class ExecutionsResource {
  ExecutionsResource(this._client);

  final Vlm _client;

  /// List all executions.
  Future<List<AgentExecutionResponse>> list({
    int? skip,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (skip != null) queryParams['skip'] = skip.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    var path = '/v1/agent/executions';
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
        .map((item) => AgentExecutionResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Get an execution by ID.
  Future<AgentExecutionResponse> get(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `id`');
    }

    final response = await _client.request('GET', '/v1/agent/executions/$id');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AgentExecutionResponse.fromJson(json);
  }

  /// Wait for an execution to complete.
  ///
  /// [id] - ID of execution to wait for
  /// [timeout] - Timeout in seconds (default: 300)
  /// [sleep] - Sleep time in seconds between checks (default: 5)
  Future<AgentExecutionResponse> wait(
    String id, {
    int timeout = 300,
    int sleep = 5,
  }) async {
    final startTime = DateTime.now();
    final timeoutDuration = Duration(seconds: timeout);

    while (DateTime.now().difference(startTime) < timeoutDuration) {
      final response = await get(id);
      if (response.status == 'completed') {
        return response;
      }
      await Future.delayed(Duration(seconds: sleep));
    }

    throw RequestTimeoutError(
      'Execution $id did not complete within $timeout seconds',
    );
  }
}
