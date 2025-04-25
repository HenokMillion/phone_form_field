import 'package:phone_numbers_parser/phone_numbers_parser.dart' as original
    show IsoCode;

/// Custom IsoCode enum that excludes unwanted countries (TW, HK, MO, AC)
enum CustomIsoCode {
  AD,
  AE,
  AF,
  AG,
  AI,
  AL,
  AM,
  AO,
  AR,
  AS,
  AT,
  AU,
  AW,
  AX,
  AZ,
  BA,
  BB,
  BD,
  BE,
  BF,
  BG,
  BH,
  BI,
  BJ,
  BL,
  BM,
  BN,
  BO,
  BQ,
  BR,
  BS,
  BT,
  BW,
  BY,
  BZ,
  CA,
  CC,
  CD,
  CF,
  CG,
  CH,
  CI,
  CK,
  CL,
  CM,
  CN,
  CO,
  CR,
  CU,
  CV,
  CW,
  CX,
  CY,
  CZ,
  DE,
  DJ,
  DK,
  DM,
  DO,
  DZ,
  EC,
  EE,
  EG,
  EH,
  ER,
  ES,
  ET,
  FI,
  FJ,
  FK,
  FM,
  FO,
  FR,
  GA,
  GB,
  GD,
  GE,
  GF,
  GG,
  GH,
  GI,
  GL,
  GM,
  GN,
  GP,
  GQ,
  GR,
  GT,
  GU,
  GW,
  GY,
  HN,
  HR,
  HT,
  HU,
  ID,
  IE,
  IL,
  IM,
  IN,
  IO,
  IQ,
  IR,
  IS,
  IT,
  JE,
  JM,
  JO,
  JP,
  KE,
  KG,
  KH,
  KI,
  KM,
  KN,
  KP,
  KR,
  KW,
  KY,
  KZ,
  LA,
  LB,
  LC,
  LI,
  LK,
  LR,
  LS,
  LT,
  LU,
  LV,
  LY,
  MA,
  MC,
  MD,
  ME,
  MF,
  MG,
  MH,
  MK,
  ML,
  MM,
  MN,
  MP,
  MQ,
  MR,
  MS,
  MT,
  MU,
  MV,
  MW,
  MX,
  MY,
  MZ,
  NA,
  NC,
  NE,
  NF,
  NG,
  NI,
  NL,
  NO,
  NP,
  NR,
  NU,
  NZ,
  OM,
  PA,
  PE,
  PF,
  PG,
  PH,
  PK,
  PL,
  PM,
  PR,
  PS,
  PT,
  PW,
  PY,
  QA,
  RE,
  RO,
  RS,
  RU,
  RW,
  SA,
  SB,
  SC,
  SD,
  SE,
  SG,
  SH,
  SI,
  SJ,
  SK,
  SL,
  SM,
  SN,
  SO,
  SR,
  SS,
  ST,
  SV,
  SX,
  SY,
  SZ,
  TA,
  TC,
  TD,
  TG,
  TH,
  TJ,
  TK,
  TL,
  TM,
  TN,
  TO,
  TR,
  TT,
  TV,
  TZ,
  UA,
  UG,
  US,
  UY,
  UZ,
  VA,
  VC,
  VE,
  VG,
  VI,
  VN,
  VU,
  WF,
  WS,
  XK,
  YE,
  YT,
  ZA,
  ZM,
  ZW;

  const CustomIsoCode();

  /// Convert from the original IsoCode to our CustomIsoCode
  static CustomIsoCode? fromOriginal(original.IsoCode isoCode) {
    // Skip excluded countries
    if (isoCode == original.IsoCode.TW ||
        isoCode == original.IsoCode.HK ||
        isoCode == original.IsoCode.MO ||
        isoCode == original.IsoCode.AC) {
      return null;
    }

    try {
      return CustomIsoCode.values.firstWhere(
        (element) => element.name == isoCode.name,
      );
    } catch (e) {
      return null; // This should never happen for non-excluded countries
    }
  }

  /// Convert back to original IsoCode
  original.IsoCode toOriginal() {
    return original.IsoCode.values.firstWhere(
      (element) => element.name == name,
    );
  }

  /// For JSON serialization
  String toJson() => name;

  /// From JSON deserialization
  static CustomIsoCode fromJson(String isoCodeStr) {
    // Block excluded countries from being deserialized
    if (isoCodeStr == 'TW' ||
        isoCodeStr == 'HK' ||
        isoCodeStr == 'MO' ||
        isoCodeStr == 'AC') {
      return CustomIsoCode.US; // Default to US for excluded countries
    }

    try {
      return CustomIsoCode.values.firstWhere(
        (element) => element.name == isoCodeStr,
      );
    } catch (e) {
      // Default to US if not found
      return CustomIsoCode.US;
    }
  }

  /// Conversion map for serialization/deserialization
  static final Map<String, CustomIsoCode> conversionMap = {
    for (var value in CustomIsoCode.values) value.name: value
  };
}
