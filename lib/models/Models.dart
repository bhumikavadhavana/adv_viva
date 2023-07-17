class Country {
  String countries;
  int population;
  List capital;
  Map<String, dynamic> lang;

  Country({
    required this.countries,
    required this.population,
    required this.capital,
    required this.lang,
  });

  factory Country.formMap(
      {required String common,
      required int population,
      required List capital,
      required Map<String, dynamic> languages}) {
    return Country(
      countries: common,
      population: population,
      capital: capital,
      lang: languages,
    );
  }
}
