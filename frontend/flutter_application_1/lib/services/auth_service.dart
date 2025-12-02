// Создайте файл: lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://localhost:3006/api/v1";
  static const String _tokenKey = "access_token";
  static const String _userEmailKey = "user_email";

  // Сохранение токена
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Получение токена
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Сохранение email пользователя
  Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  // Получение email пользователя
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Проверка авторизации
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Выход
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userEmailKey);
  }

  // Логин
  Future<Map<String, dynamic>?> login(String email, String password) async {
  final url = Uri.parse('$baseUrl/auth/login');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      if (token != null) {
        await saveToken(token);
        await saveUserEmail(email);
      }

      return data; // возвращаем Map с access_token
    } else {
      print("Ошибка: ${response.statusCode}, ${response.body}");
      return null;
    }
  } catch (e) {
    print("Ошибка подключения: $e");
    return null;
  }
}
  // Регистрация
  Future<Map<String, dynamic>?> register(String email, String password, String name) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": name,
          "role": "user",
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        
        if (token != null) {
          await saveToken(token);
          await saveUserEmail(email);
        }
        
        return data;
      } else {
        print("Ошибка: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print("Ошибка подключения: $e");
      return null;
    }
  }
}