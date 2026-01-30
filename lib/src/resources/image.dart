import 'dart:convert';

import '../types/image_generate_params.dart';
import '../types/shared/prediction_response.dart';
import '../vlmrun_client.dart';
import '../utils/http_utils.dart';

/// Resource class for image-related endpoints.
class ImageResource {
  ImageResource(this._client);

  final VlmRun _client;

  /// Generate an image prediction.
  ///
  /// [image] - A single image URL to process.
  Future<PredictionResponse> generate({
    required String image,
    String? id,
    String? callbackUrl,
    DateTime? createdAt,
    String detail = 'auto',
    String? domain,
    Map<String, dynamic>? jsonSchema,
    ImageMetadata? metadata,
    String model = 'vlm-1',
  }) async {
    final params = ImageGenerateParams(
      images: [image],
      id: id,
      callbackUrl: callbackUrl,
      createdAt: createdAt,
      detail: detail,
      domain: domain,
      jsonSchema: jsonSchema,
      metadata: metadata,
      model: model,
    );

    final response = await _client.request(
      'POST',
      '/v1/image/generate',
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
