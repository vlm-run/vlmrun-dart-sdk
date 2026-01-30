import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'resources/openai.dart';
import 'resources/schema.dart';
import 'resources/files.dart';
import 'resources/audio.dart';
import 'resources/image.dart';
import 'resources/document.dart';
import 'resources/models.dart';
import 'resources/predictions.dart';
import 'resources/agent.dart';
import 'resources/executions.dart';
import 'resources/feedback.dart';
import 'resources/hub.dart';
import 'resources/domains.dart';
import 'resources/video.dart';

/// The main client for interacting with the Vlm API.
class VlmRun {
  /// Creates a new Vlm client.
  VlmRun({
    required String bearerToken,
    String baseUrl = 'https://api.vlm.run',
    Duration timeout = const Duration(seconds: 30),
    http.Client? httpClient,
  })  : _bearerToken = bearerToken,
        _baseUrl = baseUrl,
        _timeout = timeout,
        _httpClient = httpClient ?? http.Client();

  final String _bearerToken;
  final String _baseUrl;
  final http.Client _httpClient;
  final Duration _timeout;

  /// Access to file-related endpoints.
  late final files = FilesResource(this);

  /// Access to schema-related endpoints.
  late final schema = SchemaResource(this);

  /// Access to OpenAI-compatible endpoints.
  late final openai = OpenAI(this);

  /// Access to audio-related endpoints.
  late final audio = AudioResource(this);

  /// Access to image-related endpoints.
  late final image = ImageResource(this);

  /// Access to document-related endpoints.
  late final document = DocumentResource(this);

  /// Access to model-related endpoints.
  late final models = ModelsResource(this);

  /// Access to prediction-related endpoints.
  late final predictions = PredictionsResource(this);

  /// Access to agent-related endpoints.
  late final agent = AgentResource(this);

  /// Access to execution-related endpoints.
  late final executions = ExecutionsResource(this);

  /// Access to feedback-related endpoints.
  late final feedback = FeedbackResource(this);

  /// Access to hub-related endpoints.
  late final hub = HubResource(this);

  /// Access to domain-related endpoints.
  late final domains = DomainsResource(this);

  /// Access to video-related endpoints.
  late final video = VideoResource(this);

  /// Makes an HTTP request to the Vlm API.
  @internal
  Future<http.Response> request(
    String method,
    String path, {
    String? body,
  }) async {
    final url = Uri.parse('$_baseUrl$path');
    final headers = {
      'Authorization': 'Bearer $_bearerToken',
      'Content-Type': 'application/json',
    };

    late final http.Response response;
    switch (method) {
      case 'GET':
        response =
            await _httpClient.get(url, headers: headers).timeout(_timeout);
        break;
      case 'POST':
        response = await _httpClient
            .post(url, headers: headers, body: body)
            .timeout(_timeout);
        break;
      case 'DELETE':
        response =
            await _httpClient.delete(url, headers: headers).timeout(_timeout);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }

    return response;
  }

  /// Makes a multipart form-data request to the Vlm API.
  @internal
  Future<http.Response> multipartRequest(
    String method,
    String path, {
    required http.MultipartFile file,
    Map<String, String>? fields,
  }) async {
    final url = Uri.parse('$_baseUrl$path');
    final request = http.MultipartRequest(method, url)
      ..headers['Authorization'] = 'Bearer $_bearerToken';

    // Add file
    request.files.add(file);

    // Add other fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    final streamedResponse = await _httpClient.send(request).timeout(_timeout);

    return http.Response.fromStream(streamedResponse);
  }
}
