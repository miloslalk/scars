import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:when_scars_become_art/models/care_corner_data.dart';

class CareCornerService {
  CareCornerService._();
  static final instance = CareCornerService._();

  final Map<String, CareCornerCountryData> _cache = {};

  Future<CareCornerCountryData> loadCountry(String countryId) async {
    if (_cache.containsKey(countryId)) return _cache[countryId]!;
    final raw = await rootBundle.loadString(
      'assets/data/care_corner/$countryId.json',
    );
    final data = CareCornerCountryData.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
    _cache[countryId] = data;
    return data;
  }
}
