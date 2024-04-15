import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff2c353f),
      primary: const Color(0xff2c353f),
      secondary: Colors.lime,
      // ···
      // brightness: Brightness.dark,
    ),
  );
}

final appThemeSetColors = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  extensions: [
    // Add theme extensions here...
    AppShadowTheme(),
  ],
);



class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color primaryColor;

  final Color secondaryColor;

  AppColorTheme({
    this.primaryColor = Colors.red,
    this.secondaryColor = Colors.lime,
  });

  @override
  ThemeExtension<AppColorTheme> copyWith({
    Color? appPrimaryColor,
    Color? appSecondaryColor,
  }) {
    return AppColorTheme(
      primaryColor: appPrimaryColor ?? primaryColor,
      secondaryColor: appSecondaryColor ?? secondaryColor,
    );
  }

  @override
  ThemeExtension<AppColorTheme> lerp(
    covariant ThemeExtension<AppColorTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppColorTheme();
  }
}

class AppShadowTheme extends ThemeExtension<AppShadowTheme> {
  final BoxShadow primaryShadow;
  // For Light Mode call AppShadowTheme()
  AppShadowTheme({
    this.primaryShadow = const BoxShadow(
      color: Color(0xFF6750A4),
      blurRadius: 10,
      spreadRadius: 10,
      offset: Offset(-10, 10),
      blurStyle: BlurStyle.outer,
    ),
  });
  // For dark Mode call AppShadowTheme.dark()
  factory AppShadowTheme.dark() {
    return AppShadowTheme(
      primaryShadow: const BoxShadow(
      color: Color(0xFF381E72),
      blurRadius: 10,
      spreadRadius: 10,
      offset: Offset(-10, 10),
      blurStyle: BlurStyle.outer,
      ),
    );
  }

  @override
  AppShadowTheme copyWith({
    BoxShadow? primaryShadow,
  }) {
    return AppShadowTheme(
      primaryShadow: primaryShadow ?? this.primaryShadow,
    );
  }

  @override
  ThemeExtension<AppShadowTheme> lerp(
    covariant ThemeExtension<AppShadowTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppShadowTheme();
  }
}


class AppGradientTheme extends ThemeExtension<AppGradientTheme> {
  final Gradient backgroundGradient;

  AppGradientTheme({
    required this.backgroundGradient,
  });
  // Here we can pass colorScheme to use color from color scheme only
  factory AppGradientTheme.generate({required ColorScheme colorScheme}) {
    return AppGradientTheme(
      backgroundGradient: LinearGradient(
        stops: const [0.1, 0.2, 0.9, 0.9, 0.95, 1],
        colors: [
          colorScheme.surfaceTint, // <-- Here
          colorScheme.surfaceTint,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
  
  @override
  ThemeExtension<AppGradientTheme> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
  
  @override
  ThemeExtension<AppGradientTheme> lerp(covariant ThemeExtension<AppGradientTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

 /// other methods

}

extension ThemeDataExtension on ThemeData {
  AppShadowTheme get appShadowTheme =>
      extension<AppShadowTheme>() ?? AppShadowTheme();

  AppGradientTheme get appGradientTheme =>
      extension<AppGradientTheme>() ??
      AppGradientTheme.generate(colorScheme: colorScheme);
}

class AppThemeGlobal {
  static ThemeData get lightTheme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extensions: [
          AppShadowTheme(),
          AppGradientTheme.generate(colorScheme: lightColorScheme),
        ],
      );

  static ThemeData get darkTheme => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: darkColorScheme,
        extensions: [
          AppShadowTheme.dark(),
          AppGradientTheme.generate(colorScheme: darkColorScheme),
        ],
      );

  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6750A4),
    onInverseSurface: Color(0xFFF4EFF4),
    surfaceTint: Color(0xFF9180c1), 
    onPrimary: Color(0xFFF4EFF4), 

    secondary: Color(0xFFF4EFF4), 
    onSecondary: Color(0xFFF4EFF4), 
    error: Color(0xFFF4EFF4), 
    onError: Color(0xFFF4EFF4), 
    background: Color(0xFFF4EFF4), 
    onBackground: Color(0xFFF4EFF4), 
    surface: Color(0xFFF4EFF4), 
    onSurface: Color(0xFFF4EFF4),
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    secondary: Color(0xFFCCC2DC),
    onInverseSurface: Color(0xFF313033),
    surfaceTint: Color(0xFFD0BCFF),
 
    onSecondary: Color(0xFFF4EFF4), 
    error: Color(0xFFF4EFF4), 
    onError: Color(0xFFF4EFF4), 
    background: Color(0xFFF4EFF4), 
    onBackground: Color(0xFFF4EFF4), 
    surface: Color(0xFFF4EFF4), 
    onSurface: Color(0xFFF4EFF4), 
    onPrimary: Color(0xFFF4EFF4)
  );
}