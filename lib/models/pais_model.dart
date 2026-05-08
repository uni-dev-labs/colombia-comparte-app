import 'package:app/widgets/common/status_badge.dart';

class PaisModel {
  final String flag;
  final String name;
  final int solicitudes;
  final BadgeStatus status;

  const PaisModel({
    required this.flag,
    required this.name,
    required this.solicitudes,
    required this.status,
  });
}

const List<PaisModel> paisesMock = [
  PaisModel(flag: '🇨🇴', name: 'Colombia',  solicitudes: 87, status: BadgeStatus.published),
  PaisModel(flag: '🇻🇪', name: 'Venezuela', solicitudes: 54, status: BadgeStatus.published),
  PaisModel(flag: '🇪🇨', name: 'Ecuador',   solicitudes: 41, status: BadgeStatus.published),
  PaisModel(flag: '🇵🇪', name: 'Perú',      solicitudes: 38, status: BadgeStatus.pending),
  PaisModel(flag: '🇲🇽', name: 'México',    solicitudes: 27, status: BadgeStatus.draft),
];
