import 'package:app/core/app/app_colors.dart';
import 'package:app/core/services/auth_provider.dart';
import 'package:app/models/actividad_model.dart';
import 'package:app/models/pais_model.dart';
import 'package:app/models/resumen_contenido_model.dart';
import 'package:app/widgets/common/app_drawer.dart';
import 'package:app/widgets/common/status_badge.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:app/widgets/dashboard/dashboard_card.dart';
import 'package:app/widgets/dashboard/list_item_row.dart';
import 'package:app/widgets/dashboard/metric_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardSuperAdminPage extends StatelessWidget {
  const DashboardSuperAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.formBackground,
      appBar: const _SuperAdminAppBar(),
      drawer: const AppDrawer(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WelcomeHeader(),
            SizedBox(height: 20),
            _GlobalMetricsSection(),
            SizedBox(height: 16),
            _PaisesActivosSection(),
            SizedBox(height: 16),
            _ActividadRecienteSection(),
            SizedBox(height: 16),
            _ResumenContenidoSection(),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(
        currentIndex: 0,
      ),
    );
  }
}

class _SuperAdminAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _SuperAdminAppBar();

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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.white,
                      size: 24,
                    ),
                  );
                },
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Panel Global',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const _GlobalBadge(),

              const SizedBox(width: 10),

              IconButton(
                onPressed: () async {
                  final auth = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );

                  await auth.logout();

                  if (context.mounted) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  }
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.white,
                ),
              ),

              Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.white,
                    size: 24,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.statusPendingText,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalBadge extends StatelessWidget {
  const _GlobalBadge();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final user = auth.user;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.public_rounded,
            color: AppColors.white,
            size: 13,
          ),

          const SizedBox(width: 5),

          Text(
            user?.role == 'superadmin'
                ? 'Global'
                : user?.country ?? '',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final user = auth.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hola, ${user?.name ?? 'Usuario'}',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          '${user?.role ?? ''} · Latinoamérica Comparte',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _GlobalMetricsSection extends StatelessWidget {
  const _GlobalMetricsSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Métricas globales',
      subtitle: 'Todos los países · Hoy',
      child: const Column(
        children: [
          Row(
            children: [
              MetricBox(
                value: '247',
                label: 'SOLICITUDES',
                valueColor: AppColors.metricPendingText,
                backgroundColor: AppColors.metricPendingBg,
              ),
              SizedBox(width: 8),
              MetricBox(
                value: '83',
                label: 'TESTIMONIOS',
                valueColor: AppColors.metricDraftText,
                backgroundColor: AppColors.metricDraftBg,
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            children: [
              MetricBox(
                value: '1.2k',
                label: 'USUARIOS',
                valueColor: AppColors.statusPublishedText,
                backgroundColor: AppColors.statusPublishedBg,
              ),
              SizedBox(width: 8),
              MetricBox(
                value: '6',
                label: 'PAÍSES',
                valueColor: AppColors.metricInactiveText,
                backgroundColor: AppColors.metricInactiveBg,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaisesActivosSection extends StatelessWidget {
  const _PaisesActivosSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Países activos',
      actionLabel: 'Ver todos',
      onAction: () {},
      child: Column(
        children: List.generate(
          paisesMock.length,
          (i) {
            final p = paisesMock[i];

            return ListItemRow(
              title: p.name,
              subtitle: '${p.solicitudes} solicitudes',
              leading: CircleAvatar(
                child: Text(p.flag),
              ),
              trailing: StatusBadge(status: p.status),
              showDivider: i < paisesMock.length - 1,
            );
          },
        ),
      ),
    );
  }
}

class _ActividadRecienteSection extends StatelessWidget {
  const _ActividadRecienteSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Actividad reciente',
      actionLabel: 'Ver todo',
      onAction: () {},
      child: Column(
        children: List.generate(
          actividadRecienteMock.length,
          (i) {
            final item = actividadRecienteMock[i];

            return ListItemRow(
              title: item.title,
              subtitle: item.subtitle,
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              showDivider:
                  i < actividadRecienteMock.length - 1,
            );
          },
        ),
      ),
    );
  }
}

class _ResumenContenidoSection extends StatelessWidget {
  const _ResumenContenidoSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Resumen de contenido',
      subtitle: 'Publicaciones totales',
      child: Column(
        children: List.generate(
          resumenContenidoMock.length,
          (i) {
            final item = resumenContenidoMock[i];

            return ListTile(
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              title: Text(item.label),
              subtitle: Text(
                '${item.published} publicados · ${item.draft} borradores',
              ),
            );
          },
        ),
      ),
    );
  }
}