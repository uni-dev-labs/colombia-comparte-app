import 'package:flutter/material.dart';

class PortalModel {
  final String flag;
  final String name;
  final String code;
  final String domain;
  final Color accentColor;
  final int noticias;
  final int testimonios;
  final int solicitudes;

  const PortalModel({
    required this.flag,
    required this.name,
    required this.code,
    required this.domain,
    required this.accentColor,
    required this.noticias,
    required this.testimonios,
    required this.solicitudes,
  });
}

const List<PortalModel> portalesMock = [
  PortalModel(
    flag: '🇨🇴',
    name: 'Colombia',
    code: 'COL',
    domain: 'latamcomparte.co',
    accentColor: Color(0xFFF59E0B),
    noticias: 124,
    testimonios: 45,
    solicitudes: 12,
  ),
  PortalModel(
    flag: '🇨🇱',
    name: 'Chile',
    code: 'CHL',
    domain: 'latamcomparte.cl',
    accentColor: Color(0xFFDC2626),
    noticias: 89,
    testimonios: 31,
    solicitudes: 8,
  ),
  PortalModel(
    flag: '🇪🇨',
    name: 'Ecuador',
    code: 'ECU',
    domain: 'latamcomparte.ec',
    accentColor: Color(0xFF0891B2),
    noticias: 56,
    testimonios: 19,
    solicitudes: 5,
  ),
];
