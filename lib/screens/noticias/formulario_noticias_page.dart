import 'package:app/core/app/app_colors.dart';
import 'package:app/models/pais_model.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:app/widgets/forms/app_country_dropdown.dart';
import 'package:app/widgets/forms/app_form_card.dart';
import 'package:app/widgets/forms/app_form_field.dart';
import 'package:app/widgets/forms/app_segmented_selector.dart';
import 'package:flutter/material.dart';

class FormularioNoticiasPage extends StatefulWidget {
  const FormularioNoticiasPage({super.key});

  @override
  State<FormularioNoticiasPage> createState() => _FormularioNoticiasPageState();
}

class _FormularioNoticiasPageState extends State<FormularioNoticiasPage> {
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _resumenController = TextEditingController();
  final _contenidoController = TextEditingController();

  PaisModel? _selectedCountry;
  int _selectedStatus = 0; // 0=Borrador, 1=Publicado
  int _contenidoChars = 0;
  static const int _maxContenido = 2500;

  final Set<String> _selectedCategories = {};

  static const _categories = [
    _CategoryOption(label: 'Inspiración', color: Color(0xFF7C3AC7), bg: Color(0xFFF3E8FF)),
    _CategoryOption(label: 'Corporativo', color: Color(0xFF1D4ED8), bg: Color(0xFFEFF6FF)),
    _CategoryOption(label: 'Eventos',     color: Color(0xFF15803D), bg: Color(0xFFF0FDF4)),
    _CategoryOption(label: 'Noticias',    color: Color(0xFF6B6B8A), bg: Color(0xFFF5F5F7)),
  ];

  @override
  void initState() {
    super.initState();
    _contenidoController.addListener(() {
      setState(() => _contenidoChars = _contenidoController.text.length);
    });
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleController.dispose();
    _resumenController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.formBackground,
      appBar: _FormAppBar(onPublish: _onPublish),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Column(
          children: [
            _CoverCard(controller: _imageUrlController),
            const SizedBox(height: 14),
            _ContentCard(
              titleController: _titleController,
              resumenController: _resumenController,
              contenidoController: _contenidoController,
              charCount: _contenidoChars,
              maxChars: _maxContenido,
            ),
            const SizedBox(height: 14),
            _MetadataCard(
              selectedCountry: _selectedCountry,
              onCountryChanged: (p) => setState(() => _selectedCountry = p),
              selectedCategories: _selectedCategories,
              categories: _categories,
              onCategoryToggle: (label) => setState(() {
                if (_selectedCategories.contains(label)) {
                  _selectedCategories.remove(label);
                } else {
                  _selectedCategories.add(label);
                }
              }),
            ),
            const SizedBox(height: 14),
            _StatusCard(
              selectedIndex: _selectedStatus,
              onSelected: (i) => setState(() => _selectedStatus = i),
              onSaveDraft: () => Navigator.pop(context),
              onPublish: _onPublish,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(currentIndex: 2),
    );
  }

  void _onPublish() => Navigator.pop(context);
}

// ─── Data ─────────────────────────────────────────────────────────────────────

class _CategoryOption {
  final String label;
  final Color color;
  final Color bg;
  const _CategoryOption({required this.label, required this.color, required this.bg});
}

// ─── AppBar ───────────────────────────────────────────────────────────────────

class _FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPublish;
  const _FormAppBar({required this.onPublish});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded,
                    color: AppColors.white, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  'Nueva noticia',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: onPublish,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text(
                        'Publicar',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                        width: 1, height: 24, color: AppColors.whiteTransparent),
                    IconButton(
                      icon: const Icon(Icons.expand_more_rounded,
                          color: AppColors.white, size: 20),
                      onPressed: () {},
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// _SectionCard → AppFormCard | _FieldLabel / _FilledField → AppFormField | _CountryDropdown → AppCountryDropdown

// ─── Cover Card ───────────────────────────────────────────────────────────────

class _CoverCard extends StatelessWidget {
  final TextEditingController controller;
  const _CoverCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.metricDraftBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.inputBorder, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined, color: AppColors.primaryPurple, size: 40),
                  SizedBox(height: 8),
                  Text('Agrega imagen de portada',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('Formatos recomendados: JPG, PNG (16:9)',
                      style: TextStyle(color: AppColors.textHint, fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          AppFormField(
            label: 'URL de la imagen',
            hint: 'https://ejemplo.com/imagen.jpg',
            prefixIcon: Icons.link_rounded,
            controller: controller,
            keyboardType: TextInputType.url,
          ),
        ],
      ),
    );
  }
}

// ─── Content Card ─────────────────────────────────────────────────────────────

class _ContentCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController resumenController;
  final TextEditingController contenidoController;
  final int charCount;
  final int maxChars;

  const _ContentCard({
    required this.titleController,
    required this.resumenController,
    required this.contenidoController,
    required this.charCount,
    required this.maxChars,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormField(label: 'Título', hint: 'Escribe un titular impactante...', controller: titleController, fontSize: 17),
          const SizedBox(height: 14),
          AppFormField(label: 'Resumen', hint: 'Breve descripción para el listado de noticias...', controller: resumenController, maxLines: 3),
          const SizedBox(height: 14),
          AppFormField(
            label: 'Contenido completo',
            hint: 'Desarrolla la noticia aquí...',
            controller: contenidoController,
            maxLines: 6,
            suffix: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$charCount / $maxChars',
                style: TextStyle(
                  color: charCount > maxChars ? AppColors.errorColor : AppColors.textHint,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Metadata Card ────────────────────────────────────────────────────────────

class _MetadataCard extends StatelessWidget {
  final PaisModel? selectedCountry;
  final ValueChanged<PaisModel?> onCountryChanged;
  final Set<String> selectedCategories;
  final List<_CategoryOption> categories;
  final ValueChanged<String> onCategoryToggle;

  const _MetadataCard({
    required this.selectedCountry,
    required this.onCountryChanged,
    required this.selectedCategories,
    required this.categories,
    required this.onCategoryToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Autor', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(color: AppColors.formBackground, borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.verified_user_outlined, color: AppColors.textHint, size: 18),
                SizedBox(width: 10),
                Text('Admin LatAm Comparte', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('País', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          AppCountryDropdown(
            value: selectedCountry,
            onChanged: onCountryChanged,
          ),
          const SizedBox(height: 14),
          const Text('Categoría', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((cat) {
              final selected = selectedCategories.contains(cat.label);
              return GestureDetector(
                onTap: () => onCategoryToggle(cat.label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? cat.color : cat.bg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? cat.color
                          : cat.color.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    cat.label,
                    style: TextStyle(
                      color: selected ? AppColors.white : cat.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Status Card ──────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onSaveDraft;
  final VoidCallback onPublish;

  const _StatusCard({
    required this.selectedIndex,
    required this.onSelected,
    required this.onSaveDraft,
    required this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estado de la publicación', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          AppSegmentedSelector(
            options: const ['Borrador', 'Publicado'],
            selectedIndex: selectedIndex,
            onSelected: onSelected,
          ),
          const SizedBox(height: 20),
          // Guardar borrador (outline)
          GestureDetector(
            onTap: onSaveDraft,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.inputBorder, width: 1.5),
              ),
              child: const Text(
                'Guardar borrador',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Publicar noticia (gradient)
          GestureDetector(
            onTap: onPublish,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Publicar noticia',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
