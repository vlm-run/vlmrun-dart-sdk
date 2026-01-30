import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'resources/openai.dart';
import 'resources/files.dart';
import 'resources/models.dart';
import 'resources/predictions.dart';
import 'resources/agent.dart';
import 'resources/executions.dart';
import 'resources/feedback.dart';
import 'resources/hub.dart';
import 'resources/domains.dart';
import 'resources/artifacts.dart';

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

  /// Access to OpenAI-compatible endpoints.
  late final openai = OpenAI(this);

  /// Access to model-related endpoints.
  late final models = ModelsResource(this);

  /// Access to prediction-related endpoints (list, get, wait).
  late final predictions = PredictionsResource(this);

  /// Access to image prediction endpoints.
  late final image = ImagePredictionsResource(this);

  /// Access to document prediction endpoints.
  late final document = FilePredictionsResource(this, 'document');

  /// Access to audio prediction endpoints.
  late final audio = FilePredictionsResource(this, 'audio');

  /// Access to video prediction endpoints.
  late final video = FilePredictionsResource(this, 'video');

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

  /// Access to artifact-related endpoints.
  late final artifacts = ArtifactsResource(this);

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

  /// Makes an HTTP request to the Vlm API and returns raw bytes.
  @internal
  Future<http.Response> requestBytes(
    String method,
    String path, {
    Map<String, String>? queryParams,
    Duration? timeout,
  }) async {
    var uri = Uri.parse('$_baseUrl$path');
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }
    final headers = {
      'Authorization': 'Bearer $_bearerToken',
    };

    final effectiveTimeout = timeout ?? const Duration(minutes: 2);

    late final http.Response response;
    switch (method) {
      case 'GET':
        response =
            await _httpClient.get(uri, headers: headers).timeout(effectiveTimeout);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method for bytes request: $method');
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
