import 'dart:convert';

import '../vlm_client.dart';
import '../types/feedback.dart';
import '../utils/http_utils.dart';

/// Resource class for feedback-related endpoints.
class FeedbackResource {
  FeedbackResource(this._client);

  final Vlm _client;

  /// Get feedback for an entity.
  ///
  /// [entityId] - The entity ID to get feedback for
  /// [type] - Type of entity: 'request', 'agent_execution', or 'chat'
  /// [limit] - Maximum number of items to return
  /// [offset] - Number of items to skip
  Future<FeedbackListResponse> get(
    String entityId, {
    String type = 'request',
    int limit = 10,
    int offset = 0,
  }) async {
    final queryParams = <String, String>{
      'type': type,
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    final uri = Uri.parse('/v1/feedback/$entityId').replace(queryParameters: queryParams);
    final response = await _client.request('GET', uri.toString());

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return FeedbackListResponse.fromJson(json);
  }

  /// Submit feedback.
  ///
  /// Exactly one of [requestId], [agentExecutionId], or [chatId] must be provided.
  /// At least one of [response] or [notes] must be provided.
  Future<FeedbackSubmitResponse> submit({
    String? requestId,
    String? agentExecutionId,
    String? chatId,
    Map<String, dynamic>? response,
    String? notes,
  }) async {
    final idCount = [requestId, agentExecutionId, chatId]
        .where((id) => id != null)
        .length;
    if (idCount != 1) {
      throw ArgumentError(
        'Must provide exactly one of: requestId, agentExecutionId, or chatId',
      );
    }

    if (response == null && notes == null) {
      throw ArgumentError(
        '`response` or `notes` parameter is required and cannot be null',
      );
    }

    final feedbackData = FeedbackSubmitRequest(
      requestId: requestId,
      agentExecutionId: agentExecutionId,
      chatId: chatId,
      response: response,
      notes: notes,
    );

    final httpResponse = await _client.request(
      'POST',
      '/v1/feedback/submit',
      body: jsonEncode(feedbackData.toJson()),
    );

    if (!HttpUtils.isSuccessful(httpResponse.statusCode)) {
      HttpUtils.handleErrorResponse(
        httpResponse.statusCode,
        jsonDecode(httpResponse.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(httpResponse.body) as Map<String, dynamic>;
    return FeedbackSubmitResponse.fromJson(json);
  }
}
