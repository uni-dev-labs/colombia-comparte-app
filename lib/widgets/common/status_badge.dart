import 'package:app/core/app/app_colors.dart';
import 'package:flutter/material.dart';

enum BadgeStatus { pending, published, draft }

class StatusBadge extends StatelessWidget {
  final BadgeStatus status;

  const StatusBadge({super.key, required this.status});

  static const _labels = {
    BadgeStatus.pending: 'Pendiente',
    BadgeStatus.published: 'Publicado',
    BadgeStatus.draft: 'Borrador',
  };

  static const _textColors = {
    BadgeStatus.pending: AppColors.statusPendingText,
    BadgeStatus.published: AppColors.statusPublishedText,
    BadgeStatus.draft: AppColors.statusDraftText,
  };

  static const _bgColors = {
    BadgeStatus.pending: AppColors.statusPendingBg,
    BadgeStatus.published: AppColors.statusPublishedBg,
    BadgeStatus.draft: AppColors.statusDraftBg,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColors[status],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _labels[status]!,
        style: TextStyle(
          color: _textColors[status],
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
