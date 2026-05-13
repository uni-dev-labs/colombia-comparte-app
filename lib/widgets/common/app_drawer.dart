import 'package:app/core/app/app_colors.dart';
import 'package:app/core/services/auth_provider.dart';
import 'package:app/core/utils/role_permissions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    final user = auth.user;

    final role = user?.role ?? '';

    return Drawer(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),

      child: Column(
        children: [

          const _DrawerHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),

              children: [

                const _SectionLabel('NAVEGACIÓN'),

                // SOLO SUPERADMIN
                if (RolePermissions.canAccess(
                  role,
                  '/dashboard',
                ))
                  const _DrawerItem(
                    icon: Icons.dashboard_rounded,
                    label: 'Dashboard Global',
                    route: '/dashboard',
                  ),

                // SUPERADMIN Y ADMIN PAIS
                if (RolePermissions.canAccess(
                  role,
                  '/dashboard/pais',
                ))
                  const _DrawerItem(
                    icon: Icons.bar_chart_rounded,
                    label: 'Panel por País',
                    route: '/dashboard/pais',
                  ),

                // SOLO SUPERADMIN
                if (RolePermissions.canAccess(
                  role,
                  '/portales',
                ))
                  const _DrawerItem(
                    icon: Icons.public_rounded,
                    label: 'Portales',
                    route: '/portales',
                  ),

                const Divider(
                  indent: 16,
                  endIndent: 16,
                  height: 24,
                ),

                const _SectionLabel('CONTENIDO'),

                // SOLICITUDES
                if (RolePermissions.canAccess(
                  role,
                  '/solicitudes',
                ))
                  const _DrawerItem(
                    icon: Icons.assignment_outlined,
                    label: 'Solicitudes',
                    route: '/solicitudes',
                  ),

                // TESTIMONIOS
                if (RolePermissions.canAccess(
                  role,
                  '/contenido',
                ))
                  const _DrawerItem(
                    icon: Icons.article_outlined,
                    label: 'Testimonios',
                    route: '/contenido',
                  ),

                // NOTICIAS
                if (RolePermissions.canAccess(
                  role,
                  '/noticias',
                ))
                  const _DrawerItem(
                    icon: Icons.newspaper_outlined,
                    label: 'Noticias',
                    route: '/noticias',
                  ),

                // CONTACTO
                if (RolePermissions.canAccess(
                  role,
                  '/contacto',
                ))
                  const _DrawerItem(
                    icon: Icons.contact_mail_outlined,
                    label: 'Contacto Público',
                    route: '/contacto',
                  ),

                const Divider(
                  indent: 16,
                  endIndent: 16,
                  height: 24,
                ),

                const _SectionLabel('PRÓXIMAMENTE'),

                const _DrawerItemDisabled(
                  icon: Icons.bar_chart_outlined,
                  label: 'Reportes',
                ),

                const _DrawerItemDisabled(
                  icon: Icons.group_outlined,
                  label: 'Usuarios',
                ),

                const _DrawerItemDisabled(
                  icon: Icons.settings_outlined,
                  label: 'Configuración',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          const _LogoutItem(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER
// ─────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
        ),
      ),

      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 24,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),

            child: const Icon(
              Icons.public_rounded,
              color: AppColors.white,
              size: 28,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Panel Administrativo',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Latinoamérica Comparte',
            style: TextStyle(
              color: AppColors.whiteTransparent,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LABEL
// ─────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {

  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        4,
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textHint,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ITEM
// ─────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {

  final IconData icon;
  final String label;
  final String route;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {

    final current =
        ModalRoute.of(context)?.settings.name;

    final isActive = current == route;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),

      decoration: BoxDecoration(
        color: isActive
            ? AppColors.metricDraftBg
            : Colors.transparent,

        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: isActive
              ? AppColors.primaryPurple
              : AppColors.textSecondary,
          size: 22,
        ),

        title: Text(
          label,
          style: TextStyle(
            color: isActive
                ? AppColors.primaryPurple
                : AppColors.textPrimary,

            fontSize: 14,

            fontWeight: isActive
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),

        dense: true,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        onTap: () {

          Navigator.pop(context);

          if (current != route) {
            Navigator.pushNamed(
              context,
              route,
            );
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DISABLED
// ─────────────────────────────────────────────

class _DrawerItemDisabled extends StatelessWidget {

  final IconData icon;
  final String label;

  const _DrawerItemDisabled({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.textHint,
          size: 22,
        ),

        title: Text(
          label,
          style: const TextStyle(
            color: AppColors.textHint,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 3,
          ),

          decoration: BoxDecoration(
            color: AppColors.metricInactiveBg,
            borderRadius: BorderRadius.circular(8),
          ),

          child: const Text(
            'Pronto',
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        dense: true,
        enabled: false,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOGOUT
// ─────────────────────────────────────────────

class _LogoutItem extends StatelessWidget {
  const _LogoutItem();

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),

      child: ListTile(
        leading: const Icon(
          Icons.logout_rounded,
          color: AppColors.errorColor,
          size: 22,
        ),

        title: const Text(
          'Cerrar sesión',
          style: TextStyle(
            color: AppColors.errorColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        dense: true,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        onTap: () async {

          await auth.logout();

          if (context.mounted) {

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (_) => false,
            );
          }
        },
      ),
    );
  }
}