part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        primarySwatch: Colors.amber,
        backgroundColor: Color(006600),
        primaryColor: Colors.green,
        accentColor: Color(006600),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.roboto().fontFamily);
  }
}
