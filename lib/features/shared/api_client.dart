import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final http.Client httpClient;
  final FlutterSecureStorage storage;

  ApiClient({http.Client? httpClient, FlutterSecureStorage? storage})
      : httpClient = httpClient ?? http.Client(),
        storage = storage ?? const FlutterSecureStorage();

  String get baseUrl {
    if (kIsWeb) {
      return dotenv.get('BASE_URL_WEB');
    }
    return dotenv.get('BASE_URL');
  }

  String get clientSecret => dotenv.get('CLIENT_SECRET');
  String get clientId => dotenv.get('CLIENT_ID');

  Future<Map<String, String>> getHeaders() async {
    final accessToken = await storage.read(key: 'access_token');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      final clientToken = await getClientToken();
      headers['Authorization'] = 'Bearer $clientToken';
    }

    return headers;
  }

  Future<http.Response> get(String path) async {
    final uri = Uri.http(baseUrl, path);
    final headers = await getHeaders();
    final res = await httpClient.get(uri, headers: headers);

    return res;
  }

  Future<http.Response> post(String path, Map<String, dynamic>? body) async {
    final uri = Uri.http(baseUrl, path);
    final headers = await getHeaders();
    final res = await httpClient.post(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);

    return res;
  }

  Future<http.Response> put(String path, Map<String, dynamic>? body) async {
    final uri = Uri.http(baseUrl, path);
    final headers = await getHeaders();
    final res = await httpClient.put(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);

    return res;
  }

  Future<http.Response> patch(String path, Map<String, dynamic>? body) async {
    final uri = Uri.http(baseUrl, path);
    final headers = await getHeaders();
    final res = await httpClient.patch(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);

    return res;
  }

  Future<http.Response> delete(String path) async {
    final uri = Uri.http(baseUrl, path);
    final headers = await getHeaders();
    final res = await httpClient.delete(uri, headers: headers);

    return res;
  }

  Future<String> getClientToken() async {
    final uri = Uri.http(baseUrl, '/oauth/token');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final body = {
      "grant_type": "client_credentials",
      "client_id": clientId,
      "client_secret": clientSecret
    };

    final res = await httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode != 200) {
      final errorString = data['error'] ?? 'Unknown error';
      throw Exception(
          'Failed to get client token: ${res.statusCode} $errorString');
    }

    final token = data['access_token'];
    if (token == null) {
      throw Exception('No access token in response');
    }

    return token;
  }
}
