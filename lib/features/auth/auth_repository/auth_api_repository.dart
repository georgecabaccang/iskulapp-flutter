import 'package:school_erp/features/shared/api_client.dart';

import 'schemas/schemas.dart';
import 'package:school_erp/features/shared/constants/http_status.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

// TODO: handling access token expiries and refresh token
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  String get baseUrl => dotenv.get('BASE_URL');
  String get clientSecret => dotenv.get('CLIENT_SECRET');
  String get clientId => dotenv.get('CLIENT_ID');

  Future<AuthResult> login(String email, String password) async {
    try {
      final res = await _apiClient
          .post("/api/login", {"email": email, "password": password});

      final parsed = jsonDecode(res.body);
      final String message = parsed['message'] ?? '';
      final data = parsed['data'];

      if (res.statusCode != HttpStatus.ok) {
        return AuthResult.failure(res.statusCode, message);
      }
      return AuthResult.success(
        AuthenticatedUser.fromJson(data),
        data['access_token'],
        DateTime.parse(data['token_expiry']),
      );
    } catch (e) {
      print(e);
      return AuthResult.failure(500, e.toString());
    }
  }

  Future<bool> logout(String accessToken) async {
    final res = await _apiClient.post("/api/logout", {});
    return (res.statusCode == HttpStatus.ok);
  }
}
