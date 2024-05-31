// auth_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:digital_notebook/models/user_model.dart';

const storage = FlutterSecureStorage();

class AuthProvider extends ChangeNotifier {
  String? _authToken;
  User? _currentUser;
  String _error = '';
  bool _hasError = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasError => _hasError;
  String? get authToken => _authToken;

  Future<http.Response> login(String email, String password) async {
    clearError();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        await storage.write(key: 'authToken', value: responseBody['access_token']);
        _authToken = responseBody['access_token'];
        _currentUser = User.fromJson(responseBody['user']);
      } else {
        setError('Failed to login. Status code: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      setError('Failed to login: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    clearError();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users/logout'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'},
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'authToken');
        _authToken = null;
        _currentUser = null;
      } else {
        setError('Failed to logout. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setError('Failed to logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAuthToken() async {
    try {
      final token = await storage.read(key: 'authToken');
      if (token != null) {
        _authToken = token;
      }
    } catch (e) {
      print('Error reading auth token: $e');
    }
  }

  void setError(String error) {
    _error = error;
    _hasError = true;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    _hasError = false;
    notifyListeners();
  }
}
