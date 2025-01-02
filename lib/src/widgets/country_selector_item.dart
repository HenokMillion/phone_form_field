import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';

class CountrySelectorItem extends StatelessWidget {
  final IsoCode isoCode;
  final VoidCallback onTap;
  final double flagSize;
  final bool showDialCode;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CountrySelectorItem({
    super.key,
    required this.isoCode,
    required this.onTap,
    this.flagSize = 40,
    this.showDialCode = true,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final countryLocalization = CountrySelectorLocalization.of(context) ??
        CountrySelectorLocalizationEn();

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CountryFlag.fromCountryCode(
          isoCode.name,
          height: flagSize,
          width: flagSize,
        ),
      ),
      title: Text(
        countryLocalization.countryName(isoCode),
        style: titleStyle,
      ),
      subtitle: showDialCode
          ? Text(
              '+${countryLocalization.countryDialCode(isoCode)}',
              style: subtitleStyle,
            )
          : null,
      onTap: onTap,
    );
  }
} 