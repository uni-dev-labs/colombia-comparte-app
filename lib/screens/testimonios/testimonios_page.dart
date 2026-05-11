import 'package:app/core/app/app_colors.dart';
import 'package:app/models/testimonio_model.dart';
import 'package:app/widgets/common/app_drawer.dart';
import 'package:app/widgets/common/app_filter_bar.dart';
import 'package:app/widgets/common/app_gradient_fab.dart';
import 'package:app/widgets/common/status_badge.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:flutter/material.dart';

class TestimoniosPage extends StatefulWidget {
  const TestimoniosPage({super.key});

  @override
  State<TestimoniosPage> createState() => _TestimoniosPageState();
}

class _TestimoniosPageState extends State<TestimoniosPage> {
  int _selectedFilter = 0;
  late Map<int, bool> _visibility;

  //TODO: LOS FILTERS DEBERIAN SER DINAMICOS
  static const _filters = ['Todos', 'Publicados', 'Borradores', 'Despublicados'];

  @override
  void initState() {
    super.initState();
    _visibility = {
      for (int i = 0; i < testimoniosMock.length; i++)
        i: testimoniosMock[i].isVisible,
    };
  }

  List<(int, TestimonioModel)> get _filtered {
    final all = testimoniosMock.asMap().entries
        .map((e) => (e.key, e.value))
        .toList();
    if (_selectedFilter == 0) return all;
    final targetStatus = [
      null,
      BadgeStatus.published,
      BadgeStatus.draft,
      BadgeStatus.unpublished,
    ][_selectedFilter];
    return all.where((e) => e.$2.status == targetStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      backgroundColor: AppColors.formBackground,
      appBar: _TestimoniosAppBar(),
      body: Column(
        children: [
          AppFilterBar(
            filters: const ['Todos', 'Publicados', 'Borradores', 'Despublicados'],
            selectedIndex: _selectedFilter,
            onSelected: (i) => setState(() => _selectedFilter = i),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'Sin testimonios en esta categoría',
                      style: TextStyle(color: AppColors.textHint, fontSize: 14),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final (index, testimonio) = items[i];
                      return _TestimonioCard(
                        testimonio: testimonio,
                        isVisible: _visibility[index] ?? testimonio.isVisible,
                        onToggleVisibility: (val) =>
                            setState(() => _visibility[index] = val),
                      );
                    },
                  ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: AppGradientFab(
        onPressed: () => Navigator.pushNamed(context, '/testimonios/nuevo'),
      ),
      bottomNavigationBar: const DashboardBottomNav(currentIndex: 2),
    );
  }
}

// ─── AppBar ───────────────────────────────────────────────────────────────────

class _TestimoniosAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(Icons.menu_rounded, color: AppColors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Testimonios',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '🇨🇴 Colombia',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search_rounded,
                    color: AppColors.white, size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.language_rounded,
                    color: AppColors.white, size: 22),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Testimonio Card ──────────────────────────────────────────────────────────

class _TestimonioCard extends StatelessWidget {
  final TestimonioModel testimonio;
  final bool isVisible;
  final ValueChanged<bool> onToggleVisibility;

  const _TestimonioCard({
    required this.testimonio,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  Color get _borderColor => switch (testimonio.status) {
        BadgeStatus.published => AppColors.borderPublished,
        BadgeStatus.draft => AppColors.borderDraft,
        BadgeStatus.unpublished => AppColors.borderUnpublished,
        _ => AppColors.borderDraft,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: Offset(0, 2)),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Avatar(testimonio: testimonio),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testimonio.name,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                '${testimonio.role} - ${testimonio.city}',
                                style: const TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusBadge(status: testimonio.status),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      testimonio.quote,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1, color: AppColors.inputBorder),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          testimonio.date,
                          style: const TextStyle(
                            color: AppColors.textHint,
                            fontSize: 11,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'VISIBILIDAD',
                              style: TextStyle(
                                color: AppColors.textHint,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: isVisible,
                                onChanged: onToggleVisibility,
                                activeColor: AppColors.primaryPurple,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final TestimonioModel testimonio;
  const _Avatar({required this.testimonio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: testimonio.avatarColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          testimonio.initials,
          style: TextStyle(
            color: testimonio.avatarColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// _AddFAB → reemplazado por AppGradientFab
