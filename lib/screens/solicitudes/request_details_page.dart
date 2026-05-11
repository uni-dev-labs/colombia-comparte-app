import 'package:app/core/app/app_colors.dart';
import 'package:app/models/solicitud_model.dart';
import 'package:app/widgets/dashboard/dashboard_bottom_nav.dart';
import 'package:flutter/material.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({super.key});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  SolicitudModel? _solicitud;
  SolicitudStatus? _selectedStatus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_solicitud == null) {
      _solicitud =
          ModalRoute.of(context)!.settings.arguments as SolicitudModel;
      _selectedStatus = _solicitud!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final solicitud = _solicitud;
    if (solicitud == null) return const Scaffold();

    return Scaffold(
      backgroundColor: AppColors.formBackground,
      appBar: _RequestAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            _InfoCard(solicitud: solicitud),
            const SizedBox(height: 16),
            _StatusCard(
              selectedStatus: _selectedStatus!,
              onChanged: (s) => setState(() => _selectedStatus = s),
            ),
            const SizedBox(height: 16),
            const _DangerZone(),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(currentIndex: 1),
    );
  }
}

// ─── AppBar ───────────────────────────────────────────────────────────────────

class _RequestAppBar extends StatelessWidget implements PreferredSizeWidget {
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
                  'Solicitud de contacto',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.errorContainer, size: 24),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final SolicitudModel solicitud;
  const _InfoCard({required this.solicitud});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CountryChip(flag: solicitud.flag, country: solicitud.country),
                _SolicitudStatusChip(status: solicitud.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              solicitud.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _ContactRow(icon: Icons.email_outlined, text: solicitud.email),
            const SizedBox(height: 6),
            _ContactRow(icon: Icons.phone_outlined, text: solicitud.phone),
            const SizedBox(height: 8),
            _ContactRow(
              icon: Icons.calendar_today_outlined,
              text: solicitud.receivedDate,
              isCaption: true,
            ),
            const SizedBox(height: 14),
            const Divider(color: AppColors.inputBorder, height: 1),
            const SizedBox(height: 14),
            Text(
              'Mensaje / Finalidad: ${solicitud.finalidad}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.formBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                solicitud.message,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SolicitudStatusChip extends StatelessWidget {
  final SolicitudStatus status;
  const _SolicitudStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, text) = switch (status) {
      SolicitudStatus.pendiente => ('Pendiente', AppColors.errorContainer, AppColors.errorColor),
      SolicitudStatus.gestionada => ('Gestionada', AppColors.statusRespondedBg, AppColors.statusRespondedText),
      SolicitudStatus.respondida => ('Respondida', AppColors.statusPublishedBg, AppColors.statusPublishedText),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class _CountryChip extends StatelessWidget {
  final String flag;
  final String country;
  const _CountryChip({required this.flag, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.metricDraftBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryPurple.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(flag, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            country,
            style: const TextStyle(
              color: AppColors.primaryPurple,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isCaption;
  const _ContactRow({required this.icon, required this.text, this.isCaption = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: AppColors.textHint),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: isCaption ? AppColors.textHint : AppColors.textSecondary,
              fontSize: isCaption ? 12 : 14,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Status Card ──────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final SolicitudStatus selectedStatus;
  final ValueChanged<SolicitudStatus> onChanged;

  const _StatusCard({required this.selectedStatus, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.rule_rounded, color: AppColors.primaryPurple, size: 20),
                SizedBox(width: 8),
                Text(
                  'Actualizar Estado',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _StatusRadioOption(
              label: 'Pendiente',
              value: SolicitudStatus.pendiente,
              groupValue: selectedStatus,
              activeColor: AppColors.statusPendingText,
              bgColor: AppColors.statusPendingBg,
              borderColor: Color(0xFFFFCC80),
              onChanged: onChanged,
            ),
            const SizedBox(height: 8),
            _StatusRadioOption(
              label: 'Gestionada',
              value: SolicitudStatus.gestionada,
              groupValue: selectedStatus,
              activeColor: AppColors.statusManagedText,
              bgColor: AppColors.statusManagedBg,
              borderColor: AppColors.statusManagedBorder,
              onChanged: onChanged,
            ),
            const SizedBox(height: 8),
            _StatusRadioOption(
              label: 'Respondida',
              value: SolicitudStatus.respondida,
              groupValue: selectedStatus,
              activeColor: AppColors.statusRespondedText,
              bgColor: AppColors.statusRespondedBg,
              borderColor: AppColors.statusRespondedBorder,
              onChanged: onChanged,
            ),
            const SizedBox(height: 20),
            _SaveButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _StatusRadioOption extends StatelessWidget {
  final String label;
  final SolicitudStatus value;
  final SolicitudStatus groupValue;
  final Color activeColor;
  final Color bgColor;
  final Color borderColor;
  final ValueChanged<SolicitudStatus> onChanged;

  const _StatusRadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.activeColor,
    required this.bgColor,
    required this.borderColor,
    required this.onChanged,
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _isSelected ? bgColor : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isSelected ? borderColor : AppColors.inputBorder,
            width: _isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isSelected ? activeColor : AppColors.white,
                border: Border.all(
                  color: _isSelected ? activeColor : AppColors.inputBorder,
                  width: 2,
                ),
              ),
              child: _isSelected
                  ? const Icon(Icons.check_rounded, size: 13, color: AppColors.white)
                  : null,
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                color: _isSelected ? activeColor : AppColors.textSecondary,
                fontSize: 15,
                fontWeight: _isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (_isSelected)
              Icon(Icons.check_circle_rounded, color: activeColor, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _SaveButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save_outlined, color: AppColors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Guardar cambios',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Danger Zone ──────────────────────────────────────────────────────────────

class _DangerZone extends StatelessWidget {
  const _DangerZone();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.errorColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: AppColors.errorColor, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eliminar solicitud',
                      style: TextStyle(
                        color: AppColors.errorColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Esta acción es permanente y no se puede deshacer. '
                      'Se eliminarán todos los datos asociados a este registro.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _DeleteButton(onPressed: () {}),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _DeleteButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.errorColor, width: 1.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_forever_outlined, color: AppColors.errorColor, size: 20),
            SizedBox(width: 8),
            Text(
              'Eliminar',
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
