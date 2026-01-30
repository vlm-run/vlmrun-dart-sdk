import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/agent.dart';
import '../utils/http_utils.dart';
import 'predictions.dart' show InputError;

/// Resource class for agent-related endpoints.
class AgentResource {
  AgentResource(this._client);

  final VlmRun _client;

  /// Get an agent by name, id, or prompt. Only one can be provided.
  Future<AgentInfo> get({
    String? name,
    String? id,
    String? prompt,
  }) async {
    final providedCount = [name, id, prompt].where((v) => v != null).length;
    if (providedCount != 1) {
      throw InputError(
          'Exactly one of `name`, `id`, or `prompt` must be provided');
    }

    final data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (prompt != null) data['prompt'] = prompt;

    final response = await _client.request(
      'POST',
      '/v1/agent/lookup',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AgentInfo.fromJson(json);
  }

  /// List all agents.
  Future<List<AgentInfo>> list() async {
    final response = await _client.request('GET', '/v1/agent');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => AgentInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Create an agent.
  Future<AgentCreationResponse> create({
    required AgentCreationConfig config,
    String? name,
    Map<String, dynamic>? inputs,
    String? callbackUrl,
  }) async {
    if (config.prompt == null || config.prompt!.isEmpty) {
      throw InputError('Prompt is required in config');
    }

    final data = <String, dynamic>{
      'config': config.toJson(),
    };
    if (name != null) data['name'] = name;
    if (inputs != null) data['inputs'] = inputs;
    if (callbackUrl != null) data['callback_url'] = callbackUrl;

    final response = await _client.request(
      'POST',
      '/v1/agent/create',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AgentCreationResponse.fromJson(json);
  }

  /// Execute an agent.
  Future<AgentExecutionResponse> execute({
    String? name,
    Map<String, dynamic>? inputs,
    bool batch = true,
    AgentExecutionConfig? config,
    Map<String, dynamic>? metadata,
    String? callbackUrl,
  }) async {
    if (!batch) {
      throw InputError('Batch mode is required for agent execution');
    }

    final data = <String, dynamic>{
      'batch': batch,
    };
    if (name != null) data['name'] = name;
    if (inputs != null) data['inputs'] = inputs;
    if (config != null) data['config'] = config.toJson();
    if (metadata != null) data['metadata'] = metadata;
    if (callbackUrl != null) data['callback_url'] = callbackUrl;

    final response = await _client.request(
      'POST',
      '/v1/agent/execute',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AgentExecutionResponse.fromJson(json);
  }
}
