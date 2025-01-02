import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';
import 'package:phone_form_field/src/widgets/country_selector_item.dart';

const _countriesWithoutFlags = {
  IsoCode.BQ, // Bonaire
  IsoCode.SH,
  IsoCode.AC // Saint Helena
  // Add other countries without flags here
};

abstract class CountrySelectorNavigator {
  final List<IsoCode>? countries;
  final List<IsoCode>? favorites;
  final bool showDialCode;
  final bool sortCountries;
  final String? noResultMessage;
  final bool searchAutofocus;
  final TextStyle? subtitleStyle;
  final TextStyle? titleStyle;
  final InputDecoration? searchBoxDecoration;
  final TextStyle? searchBoxTextStyle;
  final Color? searchBoxIconColor;
  final ScrollPhysics? scrollPhysics;
  final double flagSize;
  final bool useRootNavigator;

  const CountrySelectorNavigator({
    this.countries,
    this.favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator = true,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    this.sortCountries = false,
    this.noResultMessage,
    required this.searchAutofocus,
    this.subtitleStyle,
    this.titleStyle,
    this.searchBoxDecoration,
    this.searchBoxTextStyle,
    this.searchBoxIconColor,
    this.scrollPhysics,
    this.flagSize = 40,
    this.useRootNavigator = true,
  }) : showDialCode = showDialCode ?? showCountryCode ?? true;

  @Deprecated('Use [show] instead')
  Future<IsoCode?> navigate(BuildContext context) => show(context);

  Future<IsoCode?> show(BuildContext context);

  Localizations _getCountrySelectorSheet({
    /// the context of the input
    /// used to have the country selection sheet
    /// in the same language as the input if the language
    /// was overriden locally with Localizations.override
    /// see: https://github.com/flutter/flutter/issues/145824
    required BuildContext inputContext,
    required ValueChanged<IsoCode> onCountrySelected,
    ScrollController? scrollController,
  }) {
    return Localizations.override(
      context: inputContext,
      locale: Localizations.localeOf(inputContext),
      child: ListView.builder(
        controller: scrollController,
        itemCount: (countries ?? IsoCode.values).length,
        itemBuilder: (context, index) {
          final isoCode = (countries ?? IsoCode.values)[index];
          return CountrySelectorItem(
            isoCode: isoCode,
            onTap: () => onCountrySelected(isoCode),
            flagSize: flagSize,
            showDialCode: showDialCode,
            titleStyle: titleStyle,
            subtitleStyle: subtitleStyle,
          );
        },
      ),
    );
  }

  const factory CountrySelectorNavigator.dialog({
    double? height,
    double? width,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
  }) = DialogNavigator._;

  const factory CountrySelectorNavigator.page({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    bool sortCountries,
    String? noResultMessage,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
    @Deprecated('Use [Theme] instead to wrap the input, this has no effetct')
    ThemeData? appBarTheme,
  }) = PageNavigator._;

  const factory CountrySelectorNavigator.bottomSheet({
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
  }) = BottomSheetNavigator._;

  const factory CountrySelectorNavigator.modalBottomSheet({
    double? height,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
  }) = ModalBottomSheetNavigator._;

  const factory CountrySelectorNavigator.draggableBottomSheet({
    double initialChildSize,
    double minChildSize,
    double maxChildSize,
    BorderRadiusGeometry? borderRadius,
    List<IsoCode>? countries,
    List<IsoCode>? favorites,
    @Deprecated('This is always on, this can be safely removed')
    bool addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    double flagSize,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    ScrollPhysics? scrollPhysics,
  }) = DraggableModalBottomSheetNavigator._;
}

class DialogNavigator extends CountrySelectorNavigator {
  final double? height;
  final double? width;

  const DialogNavigator._({
    this.width,
    this.height,
    super.countries,
    super.favorites,
    @Deprecated('This is always on, this can be safely removed')
    super.addSeparator,
    @Deprecated('Use [showDialCode] instead') bool? showCountryCode,
    bool? showDialCode,
    super.sortCountries,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.scrollPhysics,
  });

  @override
  Future<IsoCode?> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: width,
          height: height,
          child: _getCountrySelectorSheet(
            inputContext: context,
            onCountrySelected: (country) =>
                Navigator.of(context, rootNavigator: true).pop(country),
          ),
        ),
      ),
    );
  }
}

class PageNavigator extends CountrySelectorNavigator {
  const PageNavigator._({
    super.countries,
    super.favorites,
    super.addSeparator,
    super.showDialCode,
    super.showCountryCode,
    super.sortCountries,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.scrollPhysics,
    @Deprecated('Use [Theme] instead to wrap the input, this has no effetct')
    this.appBarTheme,
  });

  final ThemeData? appBarTheme;

  Localizations _getCountrySelectorPage({
    required ValueChanged<IsoCode> onCountrySelected,
    required BuildContext inputContext,
    ScrollController? scrollController,
  }) {
    return Localizations.override(
      context: inputContext,
      locale: Localizations.localeOf(inputContext),
      child: Theme(
        data: Theme.of(inputContext),
        child: CountrySelector.page(
          onCountrySelected: onCountrySelected,
          scrollController: scrollController,
          countries: countries ?? IsoCode.values,
          favoriteCountries: favorites ?? [],
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
          showDialCode: showDialCode,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
        ),
      ),
    );
  }

  @override
  Future<IsoCode?> show(
    BuildContext context,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => _getCountrySelectorPage(
          onCountrySelected: (country) => Navigator.pop(context, country),
          inputContext: context,
        ),
      ),
    );
  }
}

class BottomSheetNavigator extends CountrySelectorNavigator {
  const BottomSheetNavigator._({
    super.countries,
    super.favorites,
    super.addSeparator = true,
    super.showDialCode,
    super.showCountryCode,
    super.sortCountries,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.scrollPhysics,
  });

  Widget _buildSearchableCountryList({
    required BuildContext context,
    required ValueChanged<IsoCode> onCountrySelected,
    required ScrollController? scrollController,
  }) {
    final searchController = TextEditingController();
    final searchFocusNode = FocusNode();
    final filteredCountries = ValueNotifier<List<IsoCode>>(countries ?? IsoCode.values);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Select Country',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: FancySearchBar(
            controller: searchController,
            focusNode: searchFocusNode,
            autofocus: searchAutofocus,
            textStyle: searchBoxTextStyle,
            decoration: searchBoxDecoration?.copyWith(
              hintText: searchBoxDecoration?.hintText ?? 'Search countries...',
            ),
            iconColor: searchBoxIconColor,
            onChanged: (value) {
              final searchTerm = value.toLowerCase();
              final allCountries = countries ?? IsoCode.values;
              
              if (searchTerm.isEmpty) {
                filteredCountries.value = allCountries;
              } else {
                final countryLocalization = CountrySelectorLocalization.of(context) ?? 
                    CountrySelectorLocalizationEn();
                
                filteredCountries.value = allCountries.where((isoCode) {
                  final countryName = countryLocalization.countryName(isoCode).toLowerCase();
                  final dialCode = countryLocalization.countryDialCode(isoCode);
                  return countryName.contains(searchTerm) || 
                         dialCode.contains(searchTerm) ||
                         isoCode.name.toLowerCase().contains(searchTerm);
                }).toList();
              }
            },
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<IsoCode>>(
            valueListenable: filteredCountries,
            builder: (context, countries, _) {
              if (countries.isEmpty) {
                return Center(
                  child: Text(
                    noResultMessage ?? 'No countries found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              
              return ListView.builder(
                controller: scrollController,
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final isoCode = countries[index];
                  return CountrySelectorItem(
                    isoCode: isoCode,
                    onTap: () => onCountrySelected(isoCode),
                    flagSize: flagSize,
                    showDialCode: showDialCode,
                    titleStyle: titleStyle,
                    subtitleStyle: subtitleStyle,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Future<IsoCode?> show(BuildContext context) {
    IsoCode? selected;
    final ctrl = showBottomSheet(
      context: context,
      builder: (_) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: SafeArea(
          child: _buildSearchableCountryList(
            context: context,
            onCountrySelected: (country) {
              selected = country;
              Navigator.pop(context, country);
            },
            scrollController: null,
          ),
        ),
      ),
    );
    return ctrl.closed.then((_) => selected);
  }
}

class ModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double? height;

  const ModalBottomSheetNavigator._({
    this.height,
    super.countries,
    super.favorites,
    super.addSeparator,
    super.showDialCode,
    super.showCountryCode,
    super.sortCountries,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.scrollPhysics,
  });

  @override
  Future<IsoCode?> show(
    BuildContext context,
  ) {
    
    return showModalBottomSheet<IsoCode>(
      context: context,
      builder: (_) => SizedBox(
        height: height ?? MediaQuery.of(context).size.height - 90,
        child: _getCountrySelectorSheet(
          inputContext: context,
          onCountrySelected: (country) => Navigator.pop(context, country),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class DraggableModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final BorderRadiusGeometry? borderRadius;

  const DraggableModalBottomSheetNavigator._({
    this.initialChildSize = 0.5,
    this.minChildSize = 0.5,
    this.maxChildSize = 0.8,
    this.borderRadius,
    super.countries,
    super.favorites,
    super.addSeparator,
    super.showDialCode,
    super.showCountryCode,
    super.sortCountries,
    super.flagSize,
    super.noResultMessage,
    super.searchAutofocus = kIsWeb,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.scrollPhysics,
    bool useRootNavigator = true,
  });

  @override
  Future<IsoCode?> show(BuildContext context) {
    final effectiveBorderRadius = borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );

    return showModalBottomSheet<IsoCode>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: effectiveBorderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle with minimal padding
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2), // Reduced from 4
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: initialChildSize,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                expand: false,
                builder: (context, scrollController) => _buildSearchableCountryList(
                  context: context,
                  onCountrySelected: (country) => Navigator.pop(context, country),
                  scrollController: scrollController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchableCountryList({
    required BuildContext context,
    required ValueChanged<IsoCode> onCountrySelected,
    required ScrollController scrollController,
  }) {
    final searchController = TextEditingController();
    final searchFocusNode = FocusNode();
    final filteredCountries = ValueNotifier<List<IsoCode>>(countries ?? IsoCode.values);

    return Column(
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(
            'Select Country',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FancySearchBar(
            controller: searchController,
            focusNode: searchFocusNode,
            autofocus: searchAutofocus,
            textStyle: searchBoxTextStyle,
            decoration: searchBoxDecoration?.copyWith(
              hintText: searchBoxDecoration?.hintText ?? 'Search countries...',
            ),
            iconColor: searchBoxIconColor,
            onChanged: (value) => _handleSearch(value, filteredCountries, context),
          ),
        ),
        // Country list
        Expanded(
          child: ValueListenableBuilder<List<IsoCode>>(
            valueListenable: filteredCountries,
            builder: (context, countries, _) {
              if (countries.isEmpty) {
                return Center(
                  child: Text(
                    noResultMessage ?? 'No countries found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final isoCode = countries[index];
                  return CountrySelectorItem(
                    isoCode: isoCode,
                    onTap: () => onCountrySelected(isoCode),
                    flagSize: flagSize,
                    showDialCode: showDialCode,
                    titleStyle: titleStyle,
                    subtitleStyle: subtitleStyle,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleSearch(String value, ValueNotifier<List<IsoCode>> filteredCountries, BuildContext context) {
    final searchTerm = value.toLowerCase();
    final allCountries = countries ?? IsoCode.values;
    
    if (searchTerm.isEmpty) {
      filteredCountries.value = allCountries;
    } else {
      final countryLocalization = CountrySelectorLocalization.of(context) ?? 
          CountrySelectorLocalizationEn();
      
      filteredCountries.value = allCountries.where((isoCode) {
        final countryName = countryLocalization.countryName(isoCode).toLowerCase();
        final dialCode = countryLocalization.countryDialCode(isoCode);
        return countryName.contains(searchTerm) || 
               dialCode.contains(searchTerm) ||
               isoCode.name.toLowerCase().contains(searchTerm);
      }).toList();
    }
  }
}

class FancySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final Color? iconColor;
  final ValueChanged<String>? onChanged;

  const FancySearchBar({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.decoration,
    this.iconColor,
    this.onChanged,
  }) : super(key: key);

  @override
  State<FancySearchBar> createState() => _FancySearchBarState();
}

class _FancySearchBarState extends State<FancySearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _showClear) {
      setState(() => _showClear = hasText);
      if (hasText) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xEEEEEEEE), // Dark subtle gray for dark theme
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: widget.iconColor ?? theme.hintColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                
                autofocus: widget.autofocus,
                style: widget.textStyle ?? theme.textTheme.bodyLarge,
                decoration: (widget.decoration ?? const InputDecoration())
                    .copyWith(
                      border: InputBorder.none,
                      fillColor: Color(0xEEEEEEEE),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                onChanged: widget.onChanged,
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: _showClear
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: widget.iconColor ?? theme.hintColor,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        widget.onChanged?.call('');
                      },
                    )
                  : const SizedBox(width: 48),
            ),
          ],
        ),
      ),
    );
  }
}
