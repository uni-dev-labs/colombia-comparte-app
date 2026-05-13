import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<bool> login(String email, String password) async {
    final response = await _authService.login(email, password);

    if (response != null) {
      _user = response;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}