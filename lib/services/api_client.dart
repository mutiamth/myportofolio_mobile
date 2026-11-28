import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri(String path) => Uri.parse('$apiBaseUrl$path');

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Request failed';

      try {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          message = decoded.values
              .expand((value) => value is List ? value : [value])
              .join(', ');
        } else {
          message = response.body;
        }
      } catch (_) {
        if (response.body.isNotEmpty) {
          message = response.body;
        }
      }

      throw ApiException(response.statusCode, message);
    }
  }

  // PROJECT

  Future<List<Project>> getProjects() async {
    final response = await _client.get(
      _uri('/api/v1/projects/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/projects/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(project.toJson()),
    );

    _ensureSuccess(response);

    return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  // EDUCATION

  Future<List<Education>> getEducations() async {
    final response = await _client.get(
      _uri('/api/v1/educations/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((item) => Education.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Education> createEducation(
    Education education, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/educations/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(education.toJson()),
    );

    _ensureSuccess(response);

    return Education.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<void> deleteEducation(int id, {required String token}) async {
    final response = await _client.delete(
      _uri('/api/v1/educations/$id/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );

    // DELETE biasanya mengembalikan status 204 tanpa response body.
    _ensureSuccess(response);
  }

  // AUTHENTICATION

  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return decoded['token'] as String;
  }

  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );

    _ensureSuccess(response);
  }

  void close() {
    _client.close();
  }
}
