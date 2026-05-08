import 'package:app/widgets/common/status_badge.dart';
import 'package:flutter/material.dart';

class NoticiaModel {
  final String title;
  final Color thumbnailColor;
  final IconData thumbnailIcon;
  final BadgeStatus status;

  const NoticiaModel({
    required this.title,
    required this.thumbnailColor,
    required this.thumbnailIcon,
    required this.status,
  });
}

const List<NoticiaModel> noticiasMock = [
  NoticiaModel(
    title: 'Impacto Comunal en Medellín',
    thumbnailColor: Color(0xFFD0D0E0),
    thumbnailIcon: Icons.groups_outlined,
    status: BadgeStatus.published,
  ),
  NoticiaModel(
    title: 'Nuevos Fondos 2024',
    thumbnailColor: Color(0xFFB8D4C0),
    thumbnailIcon: Icons.forest_outlined,
    status: BadgeStatus.draft,
  ),
];
