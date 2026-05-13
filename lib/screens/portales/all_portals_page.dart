import 'package:app/core/app/app_colors.dart';
import 'package:app/core/services/auth_provider.dart';
import 'package:app/core/utils/role_permissions.dart';
import 'package:app/models/pais_model.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:app/widgets/portales/portal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPortalsPage extends StatelessWidget {
  const AllPortalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    final role = user?.role ?? '';
    final country = user?.country ?? '';

    // 🔒 PROTEGER PANTALLA
    if (!RolePermissions.canAccess(role, '/portales')) {
      return Scaffold(
        backgroundColor: AppColors.formBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.lock_outline_rounded,
                size: 70,
                color: AppColors.textHint,
              ),
              SizedBox(height: 20),
              Text(
                'Acceso denegado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'No tienes permisos para acceder a este módulo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      );
    }

    // 🔥 FILTRO REAL POR PAÍS (USANDO name)
    final portales = portalesActivosMock.where((p) {
      if (role == 'superadmin') return true;

      return p.name == country;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.formBackground,

      appBar: _PortalesAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PortalesSubHeader(count: portales.length),
            const SizedBox(height: 16),

            ...List.generate(
              portales.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PortalCard(
                  portal: portales[i],
                  onVerContenido: () {},
                ),
              ),
            ),

            const _PortalesFooter(),
            const SizedBox(height: 8),
          ],
        ),
      ),

      bottomNavigationBar: const DashboardBottomNav(
        currentIndex: 3,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// APP BAR
// ─────────────────────────────────────────────

class _PortalesAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),

              const Expanded(
                child: Text(
                  'Portales activos',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.white,
                  size: 22,
                ),
                onPressed: () {},
              ),

              IconButton(
                icon: const Icon(
                  Icons.language_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SUBHEADER
// ─────────────────────────────────────────────

class _PortalesSubHeader extends StatelessWidget {
  final int count;

  const _PortalesSubHeader({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$count portales registrados',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppColors.inputBorder,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Acceso administrativo global',
          style: TextStyle(
            color: AppColors.textHint,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────

class _PortalesFooter extends StatelessWidget {
  const _PortalesFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.metricDraftBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.primaryPurple,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Los portales se administran de forma independiente. Como Superadmin, tienes acceso total a la moderación de contenido y gestión de solicitudes para todas las regiones.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}