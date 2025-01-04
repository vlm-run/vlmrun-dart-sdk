import 'dart:convert';

import '../types/document_generate_params.dart';
import '../types/shared/prediction_response.dart';
import '../vlm_client.dart';
import '../utils/http_utils.dart';

/// Resource class for document-related endpoints.
class DocumentResource {
  DocumentResource(this._client);

  final Vlm _client;

  /// Generate document.
  Future<PredictionResponse> generate({
    required String fileId,
    String? id,
    String? callbackUrl,
    DateTime? createdAt,
    String detail = 'auto',
    String? domain,
    Map<String, dynamic>? jsonSchema,
    DocumentMetadata? metadata,
    String model = 'vlm-1',
    bool batch = false,
  }) async {
    final params = DocumentGenerateParams(
      fileId: fileId,
      id: id,
      callbackUrl: callbackUrl,
      createdAt: createdAt,
      detail: detail,
      domain: domain,
      jsonSchema: jsonSchema,
      metadata: metadata,
      model: model,
      batch: batch,
    );

    final response = await _client.request(
      'POST',
      '/v1/document/generate',
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
