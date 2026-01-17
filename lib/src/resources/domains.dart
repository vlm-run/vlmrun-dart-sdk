import 'dart:convert';

import '../vlm_client.dart';
import '../types/hub.dart';
import '../types/generation_config.dart';
import '../utils/http_utils.dart';

/// Resource class for domain-related endpoints.
class DomainsResource {
  DomainsResource(this._client);

  final Vlm _client;

  /// List supported domains.
  Future<List<DomainInfo>> list() async {
    final response = await _client.request('GET', '/v1/domains');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => DomainInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Get schema for a domain.
  Future<SchemaResponse> getSchema({
    required String domain,
    GenerationConfig? config,
  }) async {
    final data = <String, dynamic>{
      'domain': domain,
    };
    if (config != null) data['config'] = config.toJson();

    final response = await _client.request(
      'POST',
      '/v1/schema',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SchemaResponse.fromJson(json);
  }
}
