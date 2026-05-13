import 'package:app/core/app/app_colors.dart';
import 'package:app/core/services/auth_provider.dart';
import 'package:app/widgets/auth/auth_header.dart';
import 'package:app/widgets/buttons/app_primary_button.dart';
import 'package:app/widgets/inputs/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {

    final auth = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success = await auth.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!success) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Credenciales incorrectas',
            ),
          ),
        );
      }

      return;
    }

    final user = auth.user;

    if (user == null) return;

    // SUPER ADMIN
    if (user.role == 'superadmin') {

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );

      return;
    }

    // ADMIN PAIS
    if (user.role == 'admin_pais') {

      Navigator.pushReplacementNamed(
        context,
        '/dashboard/pais',
      );

      return;
    }

    // EDITOR
    if (user.role == 'editor') {

      Navigator.pushReplacementNamed(
        context,
        '/contenido',
      );

      return;
    }

    // DEFAULT
    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.formBackground,

      body: SingleChildScrollView(
        child: Column(
          children: [

            const AuthHeader(
              title: 'Bienvenido',
              subtitle: 'Inicia sesión para continuar',
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                32,
                24,
                24,
              ),

              child: Column(
                children: [

                  AppTextField(
                    controller: emailController,
                    label: 'Correo',
                    hint: 'super@admin.com',
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 20),

                  AppTextField(
                    controller: passwordController,
                    label: 'Contraseña',
                    hint: '123456',
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  AppPrimaryButton(
                    label: 'Iniciar sesión',
                    onPressed: login,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}