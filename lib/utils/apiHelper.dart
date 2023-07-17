import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Models.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Future<List<Country>?> fetchAllCountry() async {
    String url = "https://restcountries.com/v3.1/all";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<Country> info = (decodedData
          .map((e) => Country.formMap(
          common: e['name']['common'],
          population: e['population'],
          capital: e['capital'] ?? [],
          languages: e['languages'] ?? {}))
          .toList());
      return info;
    } else {
      return null;
    }
  }

  Future<List<Country>?> fetchSearchCountry({required String countryName}) async {
    String baseUrl = "https://restcountries.com/v3.1/name/";
    String endUrl = countryName;

    String url = baseUrl + endUrl;

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<Country> info = (decodedData
          .map((e) => Country.formMap(
          common: e['name']['common'],
          population: e['population'],
          capital: e['capital'] ?? [],
          languages: e['languages'] ?? {}))
          .toList());
      return info;
    } else {
      return null;
    }
  }
}
