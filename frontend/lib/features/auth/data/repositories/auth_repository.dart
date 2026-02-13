import 'dart:convert';

import 'package:hemawan_resort/core/constants/api_constants.dart';
import 'package:hemawan_resort/features/auth/data/models/resp/login_resp.dart';
import 'package:hemawan_resort/features/auth/data/models/req/login_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final http.Client client;

  AuthRepository({required this.client});

  Future<LoginResp> login(LoginParams params) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params.toJson()),
      );
      print("=== Login response: ${response.statusCode} ===");
      print("=== Login body: ${response.body} ===");

      if (response.statusCode == 200) {
        print("=== Login success ===");
        final authResp = LoginResp.fromJson(json.decode(response.body));

        await _saveTokens(authResp);
        return authResp;
      } else {
        throw Exception('เข้าสู่ระบบไม่สำเร็จ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: $e');
    }
  }

  Future<void> _saveTokens(LoginResp authResp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', authResp.accessToken);
    await prefs.setString('refresh_token', authResp.refreshToken);
    await prefs.setString('user_email', authResp.user.email);
    await prefs.setString(
      'user_name',
      '${authResp.user.firstName} ${authResp.user.lastName}',
    );
    await prefs.setString('user_role', authResp.user.role);

    print("=== Save tokens ===");
    print("user_email: ${prefs.getString('user_email')}");
    print("user_name: ${prefs.getString('user_name')}");
    print("user_role: ${prefs.getString('user_role')}");
  }

  Future<LoginResp> loginWithGoogle(String idToken) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.googleLoginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken}),
      );
      print("=== Google Login response: ${response.statusCode} ===");
      print("=== Google Login body: ${response.body} ===");

      if (response.statusCode == 200) {
        print("=== Google Login via Spring Boot success ===");
        final authResp = LoginResp.fromJson(json.decode(response.body));
        await _saveTokens(authResp);
        return authResp;
      } else {
        throw Exception('เข้าสู่ระบบด้วย Google ไม่สำเร็จ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: $e');
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    // Revoke refresh token ฝั่ง Spring Boot
    if (refreshToken != null) {
      try {
        final response = await client.post(
          Uri.parse(ApiConstants.logoutUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'refreshToken': refreshToken}),
        );
        print("=== Logout API body: ${response.body} ===");
      } catch (e) {
        print("=== Logout API failed: $e ===");
      }
    }

    // ลบ token จาก SharedPreferences
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_email');
    await prefs.remove('user_name');
    await prefs.remove('user_role');

    // Sign out จาก Firebase + Google
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();

    final token = prefs.getString('access_token');
    final firebaseUser = FirebaseAuth.instance.currentUser;
    print("=== Logout: token after remove => $token ===");
    print("=== Logout: Firebase user after signOut => ${firebaseUser?.email ?? 'null'} ===");
  }
}
