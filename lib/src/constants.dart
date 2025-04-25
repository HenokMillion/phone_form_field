import 'package:flutter_country_selector/flutter_country_selector.dart';

/// Set of countries that should be excluded from all country selections
const excludedCountries = {
  IsoCode.AC, // Ascension Island
  IsoCode.HK, // Hong Kong
  IsoCode.TW, // Taiwan
  IsoCode.MO, // Macao
};

/// Extension methods for IsoCode filtering
extension IsoCodeFiltering on List<IsoCode> {
  /// Returns a new list with excluded countries filtered out
  List<IsoCode> filterExcludedCountries() {
    return where((code) => !excludedCountries.contains(code)).toList();
  }
}

/// Checks if an IsoCode is in the excluded list
bool isExcludedCountry(IsoCode code) {
  return excludedCountries.contains(code);
}
