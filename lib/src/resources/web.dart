import 'dart:convert';

import '../vlm_client.dart';
import '../types/web_generate_params.dart';
import '../types/shared/prediction_response.dart';
import '../utils/http_utils.dart';

/// Resource class for web-related endpoints.
class WebResource {
  WebResource(this._client);

  final Vlm _client;

  /// Generate structured prediction for the given url.
  Future<PredictionResponse> generate({
    required String url,
    String? id,
    String? callbackUrl,
    DateTime? createdAt,
    String? domain,
    WebMetadata? metadata,
    String mode = 'fast',
    String model = 'vlm-1',
  }) async {
    final params = WebGenerateParams(
      url: url,
      id: id,
      callbackUrl: callbackUrl,
      createdAt: createdAt,
      domain: domain,
      metadata: metadata,
      mode: mode,
      model: model,
    );

    final response = await _client.request(
      'POST',
      '/v1/web/generate',
      body: jsonEncode(params.toJson()),
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    return PredictionResponse.fromJson(json);
  }
}
