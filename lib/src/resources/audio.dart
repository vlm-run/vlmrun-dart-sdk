import 'dart:convert';

import '../types/audio_generate_params.dart';
import '../types/shared/prediction_response.dart';
import '../vlmrun_client.dart';
import '../utils/http_utils.dart';

/// Resource class for audio-related endpoints.
class AudioResource {
  AudioResource(this._client);

  final Vlmrun _client;

  /// Generate structured prediction for the given audio.
  Future<PredictionResponse> generate({
    String? id,
    bool batch = false,
    String? callbackUrl,
    DateTime? createdAt,
    String domain = 'audio.transcription',
    String? fileId,
    AudioMetadata? metadata,
    String model = 'vlm-1',
    String? url,
  }) async {
    final params = AudioGenerateParams(
      id: id,
      batch: batch,
      callbackUrl: callbackUrl,
      createdAt: createdAt,
      domain: domain,
      fileId: fileId,
      metadata: metadata,
      model: model,
      url: url,
    );

    final response = await _client.request(
      'POST',
      '/v1/audio/generate',
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
