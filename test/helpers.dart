import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// Mock HTTP response for testing
class MockResponse extends http.Response {
  MockResponse({
    String body = '{}',
    int statusCode = 200,
    Map<String, String>? headers,
  }) : super(
          body,
          statusCode,
          headers: headers ?? {'content-type': 'application/json'},
        );
}

/// Mock HTTP client for testing
class MockHttpClient implements http.Client {
  final Map<String, Map<String, MockResponse>> _responses = {};
  final List<http.Request> requests = [];

  void addResponse(String method, String path, MockResponse response) {
    _responses[method] = _responses[method] ?? {};
    _responses[method]![path] = response;
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final request = http.Request('GET', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    requests.add(request);

    final response = _responses['GET']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for GET ${url.path}');
    }
    return response;
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final request = http.Request('POST', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = body.toString();
    }
    requests.add(request);

    final response = _responses['POST']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for POST ${url.path}');
    }
    return response;
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final request = http.Request('DELETE', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = body.toString();
    }
    requests.add(request);

    final response = _responses['DELETE']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for DELETE ${url.path}');
    }
    return response;
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    final request = http.Request('HEAD', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    requests.add(request);

    final response = _responses['HEAD']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for HEAD ${url.path}');
    }
    return response;
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final request = http.Request('PATCH', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = body.toString();
    }
    requests.add(request);

    final response = _responses['PATCH']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for PATCH ${url.path}');
    }
    return response;
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final request = http.Request('PUT', url);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = body.toString();
    }
    requests.add(request);

    final response = _responses['PUT']?[url.path];
    if (response == null) {
      throw Exception('No mock response found for PUT ${url.path}');
    }
    return response;
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    return response.body;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    return response.bodyBytes;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = _responses[request.method]?[request.url.path];
    if (response == null) {
      throw Exception(
          'No mock response found for ${request.method} ${request.url.path}');
    }
    return http.StreamedResponse(
      Stream.value(utf8.encode(response.body)),
      response.statusCode,
    );
  }

  @override
  void close() {}

  /// Helper function to load JSON fixture
  static Map<String, dynamic> loadJsonFixture(String jsonString) {
    return json.decode(jsonString) as Map<String, dynamic>;
  }
}
