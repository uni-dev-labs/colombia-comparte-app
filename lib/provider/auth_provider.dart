import 'package:app/models/user_model.dart';
import 'package:app/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthStatus { idle, loading, authenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final FlutterSecureStorage _storage;

  AuthStatus _status = AuthStatus.idle;
  User? _user;
  String? _errorMessage;

  static const _tokenKey = 'auth_token';

  AuthProvider({
    AuthService? authService,
    FlutterSecureStorage? storage,
  })  : _authService = authService ?? AuthService(),
        _storage = storage ?? const FlutterSecureStorage();

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<bool> login({required String email, required String password}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final UserResponse response = await _authService.login(
        email: email,
        password: password,
      );

      await _storage.write(key: _tokenKey, value: response.token);

      _user = response.user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      final data = e.response?.data;
      _errorMessage = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : 'Error al conectar con el servidor';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Error inesperado. Intenta de nuevo.';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    _user = null;
    _status = AuthStatus.idle;
    notifyListeners();
  }
}
