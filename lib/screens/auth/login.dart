import 'package:app/core/app/app_colors.dart';
import 'package:app/provider/auth_provider.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final auth = context.read<AuthProvider>();

    final success = await auth.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage ?? 'Error al iniciar sesión'),
          backgroundColor: AppColors.errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthProvider, bool>(
      (auth) => auth.status == AuthStatus.loading,
    );

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
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    label: 'Correo electrónico',
                    hint: 'admin@latamcomparte.org',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Contraseña',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: AppColors.linkColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AppPrimaryButton(
                    label: isLoading ? 'Iniciando sesión...' : 'Iniciar sesión →',
                    onPressed: isLoading ? null : _handleLogin,
                  ),
                  const SizedBox(height: 32),
                  const _SocialDivider(),
                  const SizedBox(height: 20),
                  const _SocialButtons(),
                  const SizedBox(height: 20),
                  const _SecurityDisclaimer(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialDivider extends StatelessWidget {
  const _SocialDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.inputBorder, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'O ACCEDE CON SUCURSAL',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.inputBorder, thickness: 1)),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconButton(icon: Icons.language_rounded, onTap: () {}),
        const SizedBox(width: 16),
        _SocialIconButton(icon: Icons.hub_outlined, onTap: () {}),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: Icon(icon, color: AppColors.primaryPurple, size: 22),
      ),
    );
  }
}

class _SecurityDisclaimer extends StatelessWidget {
  const _SecurityDisclaimer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Acceso restringido únicamente a personal autorizado de\nLatinoamérica Comparte. El uso no autorizado de este portal\nestá sujeto a monitoreo.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textHint,
            fontSize: 11,
            height: 1.6,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield_outlined, color: AppColors.textHint, size: 14),
            SizedBox(width: 4),
            Text(
              'SECURE CONNECT',
              style: TextStyle(
                color: AppColors.textHint,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
