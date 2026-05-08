class SolicitudModel {
  final String name;
  final String city;
  final String initials;

  const SolicitudModel({
    required this.name,
    required this.city,
    required this.initials,
  });
}

const List<SolicitudModel> solicitudesMock = [
  SolicitudModel(name: 'Lucía Ramírez', city: 'Bogotá, CO',   initials: 'LR'),
  SolicitudModel(name: 'Mateo Gómez',   city: 'Medellín, CO', initials: 'MG'),
  SolicitudModel(name: 'Elena Vargas',  city: 'Cali, CO',     initials: 'EV'),
];
