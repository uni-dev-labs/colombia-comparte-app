import 'package:app/widgets/common/status_badge.dart';
import 'package:flutter/material.dart';

class TestimonioModel {
  final String name;
  final String initials;
  final Color avatarColor;
  final BadgeStatus status;

  const TestimonioModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
    required this.status,
  });
}

const List<TestimonioModel> testimoniosMock = [
  TestimonioModel(
    name: 'Adriana Castro',
    initials: 'AC',
    avatarColor: Color(0xFF7C3AC7),
    status: BadgeStatus.published,
  ),
  TestimonioModel(
    name: 'Carlos Ruiz',
    initials: 'CR',
    avatarColor: Color(0xFF8E8EA0),
    status: BadgeStatus.draft,
  ),
];
