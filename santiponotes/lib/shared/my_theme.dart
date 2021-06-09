part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0xFFf2f2f2),
      scaffoldBackgroundColor: Color(0xFFf2f2f2),
      primaryColor: Colors.deepOrange[400],
      accentColor: Colors.deepOrange[200],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0xFF262626),
      scaffoldBackgroundColor: Color(0xFF262626),
      primaryColor: Colors.deepOrange[200],
      accentColor: Colors.deepOrange[200],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
}
