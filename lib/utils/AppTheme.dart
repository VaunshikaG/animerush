import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Quicksand',
    brightness: Brightness.light,
    useMaterial3: true,
    primarySwatch: Colors.orange,
    primaryColor: CustomTheme.themeColor1,
    scaffoldBackgroundColor: CustomTheme.white,
    textTheme: GoogleFonts.quicksandTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodySmall: TextStyle(
              fontSize: 14,
              color: CustomTheme.black,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: CustomTheme.black,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
    dividerTheme: DividerThemeData(color: CustomTheme.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: CustomTheme.white,
      selectedItemColor: CustomTheme.themeColor1,
      unselectedItemColor: CustomTheme.black,
    ),
    listTileTheme: ListTileThemeData(
      textColor: CustomTheme.black,
      iconColor: CustomTheme.black,
    ),
    iconTheme: IconThemeData(
      color: CustomTheme.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: CustomTheme.themeColor1,
        textStyle: TextStyle(color: CustomTheme.themeColor1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: CustomTheme.themeColor1,
        textStyle: TextStyle(color: CustomTheme.themeColor1),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      modalBackgroundColor: CustomTheme.white,
      modalElevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // filled: true,
      // fillColor: CustomTheme.white,
      labelStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      hintStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      prefixStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Quicksand',
    brightness: Brightness.dark,
    useMaterial3: true,
    primarySwatch: Colors.orange,
    primaryColor: CustomTheme.themeColor1,
    scaffoldBackgroundColor: CustomTheme.black,
    highlightColor: CustomTheme.blueGrey50,
    disabledColor: CustomTheme.grey3,
    hintColor: CustomTheme.grey2,
    // dialogBackgroundColor: const Color(0xFF4F5A69),
    // dialogBackgroundColor: const Color(0xFF333A44),
    dividerColor: CustomTheme.black,
    splashColor: CustomTheme.transparent,
    hoverColor: CustomTheme.themeColor2,
    indicatorColor: Colors.cyan,
    appBarTheme: AppBarTheme(
      backgroundColor: CustomTheme.black,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: CustomTheme.grey1,
      surfaceTintColor: CustomTheme.grey1,
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: CustomTheme.themeColor1,
      background: CustomTheme.white,
      error: CupertinoColors.systemRed,
      secondary: CustomTheme.grey,
      surface: CustomTheme.grey1,
      tertiary: Colors.blueGrey.shade900,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      ThemeData.dark().textTheme.copyWith(
            displaySmall: TextStyle(
              fontSize: 14,
              color: CustomTheme.white,
              fontWeight: FontWeight.w300,
            ),
            displayMedium: TextStyle(
              fontSize: 20,
              color: CustomTheme.white,
              fontWeight: FontWeight.w400,
            ),
            displayLarge: TextStyle(
              fontSize: 25,
              color: CustomTheme.white,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              color: CustomTheme.white,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: CustomTheme.white,
              fontWeight: FontWeight.w400,
            ),
            bodyLarge: TextStyle(
              fontSize: 15,
              color: CustomTheme.themeColor1,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              fontSize: 13,
              color: CustomTheme.white,
              fontWeight: FontWeight.w400,
            ),
            titleMedium: TextStyle(
              fontSize: 14,
              color: CustomTheme.white,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              fontSize: 14,
              color: CustomTheme.black,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: TextStyle(
              fontSize: 15,
              color: CustomTheme.grey400,
              fontWeight: FontWeight.w500,
            ),
            labelSmall: TextStyle(
              color: CustomTheme.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              fontSize: 14,
              color: CustomTheme.themeColor1,
              fontWeight: FontWeight.w600,
            ),
            labelLarge: TextStyle(
              fontSize: 17,
              color: CustomTheme.themeColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: CustomTheme.themeColor1,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.quicksand(
        fontSize: 13.5,
        color: CustomTheme.themeColor1,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.quicksand(
        fontSize: 13.5,
        color: CustomTheme.white,
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: CustomTheme.themeColor1,
      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: CustomTheme.grey1,
      collapsedIconColor: CustomTheme.grey1,
      backgroundColor: CustomTheme.grey1,
      collapsedBackgroundColor: CustomTheme.grey1,
      childrenPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    dividerTheme: DividerThemeData(color: CustomTheme.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: CustomTheme.white,
      selectedItemColor: CustomTheme.themeColor1,
      unselectedItemColor: CustomTheme.black,
    ),
    listTileTheme: ListTileThemeData(
      textColor: CustomTheme.black,
      iconColor: CustomTheme.black,
    ),
    iconTheme: IconThemeData(
      color: CustomTheme.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: CustomTheme.themeColor1,
        textStyle: TextStyle(color: CustomTheme.themeColor1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: CustomTheme.themeColor1,
        textStyle: TextStyle(color: CustomTheme.themeColor1),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      modalBackgroundColor: CustomTheme.white,
      modalElevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      hintStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      prefixStyle: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: CustomTheme.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomTheme.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomTheme.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomTheme.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomTheme.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static ButtonStyle outlinedBtn1 = ButtonStyle(
    side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
    alignment: Alignment.centerLeft,
    foregroundColor: MaterialStateProperty.all<Color>(CustomTheme.grey1),
    backgroundColor: MaterialStateProperty.all<Color>(CustomTheme.grey1),
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontFamily: 'Quicksand')),
  );
}
