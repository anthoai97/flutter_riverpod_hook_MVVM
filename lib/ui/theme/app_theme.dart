import 'package:dayaway_partner/data/local/shared_pref_service.dart';
import 'package:dayaway_partner/ui/theme/app_colors.dart';
import 'package:dayaway_partner/ui/theme/app_text_theme.dart';
import 'package:dayaway_partner/ui/theme/font_size.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeModeProvider =
    StateNotifierProvider<StateController<ThemeMode>, ThemeMode>((ref) {
  final themeModeSaved = ref.read(sharedPrefServiceProvider).theme;

  ThemeMode? themeMode;
  if (themeModeSaved != null) {
    themeMode = EnumToString.fromString(ThemeMode.values, themeModeSaved);
  }
  return StateController(themeMode ?? ThemeMode.light);
});

final appThemeProvider = Provider<AppTheme>((ref) {
  final mode = ref.watch(appThemeModeProvider);
  switch (mode) {
    case ThemeMode.dark:
      return AppTheme.dark();
    case ThemeMode.light:
    default:
      return AppTheme.light();
  }
});

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.textTheme,
    required this.appColors,
  });

  final ThemeMode mode;
  final ThemeData data;
  final AppTextTheme textTheme;
  final AppColors appColors;

  static const double _buttonRadius = 2.0;

  static ButtonThemeData _buildButtonThemeData(AppColors colors) {
    return const ButtonThemeData().copyWith(
      padding: _buttonPadding,
      minWidth: double.infinity,
      disabledColor: colors.disabled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
      splashColor: Colors.white.withOpacity(0.1),
    );
  }

  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
      horizontal: DimensionsDef.globalPadding, vertical: 10);

  static final TextStyle _buttonTextStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ));

  static TextButtonThemeData _buildTextButtonThemeData(AppColors appColors) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: appColors.primary100,
        alignment: Alignment.center,
        padding: _buttonPadding,
        textStyle: _buttonTextStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        onSurface: Colors.white,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlineButtonTheme(AppColors appColors) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: appColors.primary100,
        alignment: Alignment.center,
        padding: _buttonPadding,
        textStyle: _buttonTextStyle,
        side: BorderSide(width: 1, color: appColors.primary100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
      ),
    );
  }

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();

    final themeData = ThemeData.light().copyWith(
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      brightness: Brightness.dark,
      splashFactory: InkRipple.splashFactory,
      buttonTheme: _buildButtonThemeData(appColors),
      textButtonTheme: _buildTextButtonThemeData(appColors),
      outlinedButtonTheme: _buildOutlineButtonTheme(appColors),
    );

    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(defaultTextColor: appColors.primary100),
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();

    final themeData = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      brightness: Brightness.dark,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      splashFactory: InkRipple.splashFactory,
      buttonTheme: _buildButtonThemeData(appColors),
      textButtonTheme: _buildTextButtonThemeData(appColors),
      outlinedButtonTheme: _buildOutlineButtonTheme(appColors),
    );

    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(defaultTextColor: appColors.primary100),
      appColors: appColors,
    );
  }
}
