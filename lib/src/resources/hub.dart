import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/hub.dart';
import '../utils/http_utils.dart';

/// Resource class for hub-related endpoints.
class HubResource {
  HubResource(this._client);

  final VlmRun _client;

  /// Get hub info.
  Future<HubInfoResponse> info() async {
    final response = await _client.request('GET', '/v1/hub/info');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return HubInfoResponse.fromJson(json);
  }

  /// List supported domains.
  Future<List<DomainInfo>> listDomains() async {
    final response = await _client.request('GET', '/v1/hub/domains');

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
  Future<HubSchemaResponse> getSchema({
    required String domain,
    String? gqlStmt,
  }) async {
    final data = <String, dynamic>{
      'domain': domain,
    };
    if (gqlStmt != null) data['gql_stmt'] = gqlStmt;

    final response = await _client.request(
      'POST',
      '/v1/hub/schema',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return HubSchemaResponse.fromJson(json);
  }
}
