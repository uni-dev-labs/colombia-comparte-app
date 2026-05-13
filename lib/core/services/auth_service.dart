import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/user_model.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<UserModel?> login(String email, String password) async {

    // SUPER ADMIN
    if (email == 'super@admin.com' && password == '123456') {

      final user = UserModel(
        name: 'Carlos',
        email: email,
        role: 'superadmin',
        country: 'Global',
        token: 'token_super_admin',
      );

      await _storage.write(key: 'token', value: user.token);

      return user;
    }

    // ADMIN PAIS
    if (email == 'colombia@admin.com' && password == '123456') {

      final user = UserModel(
        name: 'Marcela',
        email: email,
        role: 'admin_pais',
        country: 'Colombia',
        token: 'token_admin_colombia',
      );

      await _storage.write(key: 'token', value: user.token);

      return user;
    }

    // EDITOR
    if (email == 'editor@admin.com' && password == '123456') {

      final user = UserModel(
        name: 'Juan',
        email: email,
        role: 'editor',
        country: 'Colombia',
        token: 'token_editor',
      );

      await _storage.write(key: 'token', value: user.token);

      return user;
    }

    return null;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}