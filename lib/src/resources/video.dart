import 'dart:convert';

import '../types/video_generate_params.dart';
import '../types/shared/prediction_response.dart';
import '../vlm_client.dart';
import '../utils/http_utils.dart';

/// Resource class for video-related endpoints.
class VideoResource {
  VideoResource(this._client);

  final Vlm _client;

  /// Generate structured prediction for the given video.
  Future<PredictionResponse> generate({
    String? fileId,
    String? url,
    String? id,
    bool batch = false,
    String? callbackUrl,
    DateTime? createdAt,
    String? domain,
    VideoMetadata? metadata,
    String model = 'vlm-1',
    Map<String, dynamic>? config,
  }) async {
    if (fileId == null && url == null) {
      throw ArgumentError('Either `fileId` or `url` must be provided');
    }
    if (fileId != null && url != null) {
      throw ArgumentError('Only one of `fileId` or `url` can be provided');
    }

    final params = VideoGenerateParams(
      id: id,
      batch: batch,
      callbackUrl: callbackUrl,
      createdAt: createdAt,
      domain: domain,
      fileId: fileId,
      metadata: metadata,
      model: model,
      url: url,
      config: config,
    );

    final response = await _client.request(
      'POST',
      '/v1/video/generate',
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
