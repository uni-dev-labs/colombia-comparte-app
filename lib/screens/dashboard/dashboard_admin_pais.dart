import 'package:app/core/app/app_colors.dart';
import 'package:app/widgets/common/status_badge.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:app/widgets/dashboard/dashboard_card.dart';
import 'package:app/widgets/dashboard/list_item_row.dart';
import 'package:app/widgets/dashboard/metric_box.dart';
import 'package:app/widgets/dashboard/outline_action_button.dart';
import 'package:flutter/material.dart';

class DashboardAdminPaisPage extends StatelessWidget {
  const DashboardAdminPaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.formBackground,
      appBar: _DashboardAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WelcomeHeader(),
            SizedBox(height: 20),
            _MetricsSection(),
            SizedBox(height: 16),
            _SolicitudesSection(),
            SizedBox(height: 16),
            _TestimoniosSection(),
            SizedBox(height: 16),
            _NoticiasSection(),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(currentIndex: 0),
    );
  }
}

// ─── AppBar ───────────────────────────────────────────────────────────────────

class _DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.menu_rounded, color: AppColors.white, size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Mi Panel',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _CountryChip(),
              const SizedBox(width: 10),
              const Icon(Icons.language_rounded,
                  color: AppColors.white, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountryChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🇨🇴', style: TextStyle(fontSize: 13)),
          SizedBox(width: 5),
          Text(
            'Colombia',
            style: TextStyle(
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

// ─── Welcome ──────────────────────────────────────────────────────────────────

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hola, Marcela',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Administradora · Colombia',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}

// ─── Metrics ──────────────────────────────────────────────────────────────────

class _MetricsSection extends StatelessWidget {
  const _MetricsSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Métricas del día',
      subtitle: 'Colombia Comparte',
      badge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.metricDraftBg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'CO',
          style: TextStyle(
            color: AppColors.metricDraftText,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      child: const Row(
        children: [
          MetricBox(
            value: '5',
            label: 'PENDIENTES',
            valueColor: AppColors.metricPendingText,
            backgroundColor: AppColors.metricPendingBg,
          ),
          SizedBox(width: 8),
          MetricBox(
            value: '3',
            label: 'BORRADORES',
            valueColor: AppColors.metricDraftText,
            backgroundColor: AppColors.metricDraftBg,
          ),
          SizedBox(width: 8),
          MetricBox(
            value: '2',
            label: 'INACTIVOS',
            valueColor: AppColors.metricInactiveText,
            backgroundColor: AppColors.metricInactiveBg,
          ),
        ],
      ),
    );
  }
}

// ─── Solicitudes ──────────────────────────────────────────────────────────────

class _SolicitudesSection extends StatelessWidget {
  const _SolicitudesSection();

  static const _items = [
    (name: 'Lucía Ramírez', city: 'Bogotá, CO', initials: 'LR'),
    (name: 'Mateo Gómez', city: 'Medellín, CO', initials: 'MG'),
    (name: 'Elena Vargas', city: 'Cali, CO', initials: 'EV'),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Últimas solicitudes',
      actionLabel: 'Ver todas',
      onAction: () {},
      child: Column(
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          return ListItemRow(
            title: item.name,
            subtitle: item.city,
            leading: AvatarLeading(initials: item.initials),
            trailing: const StatusBadge(status: BadgeStatus.pending),
            showDivider: i < _items.length - 1,
          );
        }),
      ),
    );
  }
}

// ─── Testimonios ──────────────────────────────────────────────────────────────

class _TestimoniosSection extends StatelessWidget {
  const _TestimoniosSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Mis testimonios',
      child: Column(
        children: [
          ListItemRow(
            title: 'Adriana Castro',
            subtitle: '',
            leading: AvatarLeading(
              initials: 'AC',
              color: AppColors.primaryPurple,
            ),
            trailing: const StatusBadge(status: BadgeStatus.published),
          ),
          ListItemRow(
            title: 'Carlos Ruiz',
            subtitle: '',
            leading: AvatarLeading(
              initials: 'CR',
              color: AppColors.metricInactiveText,
            ),
            trailing: const StatusBadge(status: BadgeStatus.draft),
            showDivider: false,
          ),
          const SizedBox(height: 12),
          OutlineActionButton(
            label: 'Nuevo testimonio +',
            icon: Icons.add_circle_outline_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ─── Noticias ─────────────────────────────────────────────────────────────────

class _NoticiasSection extends StatelessWidget {
  const _NoticiasSection();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: 'Mis noticias',
      child: Column(
        children: [
          ListItemRow(
            title: 'Impacto Comunal en Medellín',
            subtitle: '',
            leading: const ImageLeading(
              color: Color(0xFFD0D0E0),
              icon: Icons.groups_outlined,
            ),
            trailing: const StatusBadge(status: BadgeStatus.published),
          ),
          ListItemRow(
            title: 'Nuevos Fondos 2024',
            subtitle: '',
            leading: const ImageLeading(
              color: Color(0xFFB8D4C0),
              icon: Icons.forest_outlined,
            ),
            trailing: const StatusBadge(status: BadgeStatus.draft),
            showDivider: false,
          ),
          const SizedBox(height: 12),
          OutlineActionButton(
            label: 'Nueva noticia +',
            icon: Icons.add_circle_outline_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
