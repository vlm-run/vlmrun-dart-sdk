import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/skill.dart';
import '../utils/http_utils.dart';

/// Resource class for skill-related endpoints.
class SkillsResource {
  SkillsResource(this._client);

  final VlmRun _client;

  /// List available skills.
  ///
  /// [limit] - Max items to return (1-1000, default 25)
  /// [offset] - Number of items to skip
  /// [orderBy] - Sort field (created_at, updated_at, name)
  /// [descending] - Sort direction (default true)
  /// [grouped] - If true, return only the latest version per skill name
  Future<List<SkillInfo>> list({
    int limit = 25,
    int offset = 0,
    String orderBy = 'created_at',
    bool descending = true,
    bool grouped = false,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      'offset': offset.toString(),
      'order_by': orderBy,
      'descending': descending.toString(),
      'grouped': grouped.toString(),
    };

    var path = '/v1/skills';
    final uri = Uri.parse(path).replace(queryParameters: queryParams);
    path = uri.toString();

    final response = await _client.request('GET', path);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => SkillInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Lookup a skill by name or ID.
  ///
  /// If [id] is provided, fetches the skill directly by ID.
  /// Otherwise, looks up by [name] (and optional [skillVersion]).
  Future<SkillInfo> get({
    String? name,
    String? id,
    String? skillVersion,
  }) async {
    if (id != null && id.isNotEmpty) {
      final response = await _client.request('GET', '/v1/skills/$id');

      if (!HttpUtils.isSuccessful(response.statusCode)) {
        HttpUtils.handleErrorResponse(
          response.statusCode,
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return SkillInfo.fromJson(json);
    } else if (name != null && name.isNotEmpty) {
      final data = <String, dynamic>{'name': name};
      if (skillVersion != null) data['skill_version'] = skillVersion;

      final response = await _client.request(
        'POST',
        '/v1/skills/lookup',
        body: jsonEncode(data),
      );

      if (!HttpUtils.isSuccessful(response.statusCode)) {
        HttpUtils.handleErrorResponse(
          response.statusCode,
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return SkillInfo.fromJson(json);
    } else {
      throw ArgumentError('Either `name` or `id` must be provided.');
    }
  }

  /// Create a new skill.
  ///
  /// Skills can be created from a prompt (with optional JSON schema),
  /// from a chat session, or from an uploaded skill zip file.
  Future<SkillInfo> create({
    String? prompt,
    Map<String, dynamic>? jsonSchema,
    String? sessionId,
    String? fileId,
    String? name,
    String? description,
  }) async {
    final data = <String, dynamic>{};
    if (prompt != null) data['prompt'] = prompt;
    if (jsonSchema != null) data['json_schema'] = jsonSchema;
    if (sessionId != null) data['session_id'] = sessionId;
    if (fileId != null) data['file_id'] = fileId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;

    final response = await _client.request(
      'POST',
      '/v1/skills/create',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SkillInfo.fromJson(json);
  }

  /// Update an existing skill (creates a new version).
  Future<SkillInfo> update({
    required String skillId,
    String? fileId,
    String? description,
  }) async {
    final data = <String, dynamic>{};
    if (fileId != null) data['file_id'] = fileId;
    if (description != null) data['description'] = description;

    final response = await _client.request(
      'POST',
      '/v1/skills/$skillId/update',
      body: jsonEncode(data),
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SkillInfo.fromJson(json);
  }

  /// Get a presigned download URL for a skill zip.
  Future<SkillDownloadResponse> download(String skillId) async {
    final response = await _client.request(
      'GET',
      '/v1/skills/$skillId/download',
    );

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SkillDownloadResponse.fromJson(json);
  }
}
