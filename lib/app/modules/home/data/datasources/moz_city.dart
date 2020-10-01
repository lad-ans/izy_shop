class MozCity {
  String city;
  String country;

  MozCity({
    this.city,
    this.country,
  });

  static final List<MozCity> cities = [
    MozCity(city: 'Maputo', country: 'Mozambique'),
    MozCity(city: 'Matola', country: 'Mozambique'),
  ];
}
