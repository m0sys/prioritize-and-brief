import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './routes.dart';
import './data/items_injector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return TodoItemsService(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: _mainTheme,
        home: Routes(),
      ),
    );
  }
}

// Color variables
const primaryColor = Color(0xFFF344955);
const primaryColorLight = Color(0xFFF4A6572);
const primaryColorDark = Color(0xFFF232F34);
const accentColor = Color(0xFFFF9AA33);
const surfaceColor = primaryColor;
const onPrimaryColor = Color(0xFFFFFFFFF);
const onAccentColor = Color(0xFFF000000);
const onSurfaceColor = onPrimaryColor;

enum ThemeType { Primary, Accent, Surface }
final ThemeData _mainTheme = _buildMainThemeLight();

ThemeData _buildMainThemeLight() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: accentColor,
    primaryColor: primaryColor,
    hintColor: accentColor,
    indicatorColor: accentColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: accentColor,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: surfaceColor,
    cardColor: primaryColor,
    cardTheme: CardTheme(color: primaryColorDark, elevation: 8.0),
    dialogTheme: base.dialogTheme.copyWith(
      backgroundColor: surfaceColor,
      elevation: 4.0,
      titleTextStyle:
          _buildMainTextTheme(base.textTheme, ThemeType.Primary).title,
      contentTextStyle:
          _buildMainTextTheme(base.textTheme, ThemeType.Surface).body1,
    ),
    textSelectionColor: primaryColor,
    textTheme: _buildMainTextTheme(base.textTheme, ThemeType.Primary),
    primaryTextTheme:
        _buildMainTextTheme(base.primaryTextTheme, ThemeType.Primary),
    accentTextTheme:
        _buildMainTextTheme(base.accentTextTheme, ThemeType.Accent),
    inputDecorationTheme:
        InputDecorationTheme(focusColor: accentColor, hoverColor: accentColor),
  );
}

TextTheme _buildMainTextTheme(TextTheme base, ThemeType type) {
  return base
      .copyWith(
          headline: base.headline.copyWith(
              fontSize: englishLike2018.headline.fontSize,
              fontWeight: englishLike2018.headline.fontWeight,
              letterSpacing: englishLike2018.headline.letterSpacing,
              textBaseline: englishLike2018.headline.textBaseline,
              color: type != ThemeType.Accent && type != ThemeType.Primary
                  ? onSurfaceColor
                  : type != ThemeType.Accent ? onPrimaryColor : onAccentColor),
          title: base.title.copyWith(
              fontSize: englishLike2018.title.fontSize,
              fontWeight: englishLike2018.title.fontWeight,
              letterSpacing: englishLike2018.title.letterSpacing,
              textBaseline: englishLike2018.title.textBaseline,
              color: type != ThemeType.Accent && type != ThemeType.Primary
                  ? onSurfaceColor
                  : type != ThemeType.Accent ? onPrimaryColor : onAccentColor),
          caption: base.caption.copyWith(
              fontSize: englishLike2018.caption.fontSize,
              fontWeight: englishLike2018.caption.fontWeight,
              letterSpacing: englishLike2018.caption.letterSpacing,
              textBaseline: englishLike2018.caption.textBaseline,
              color: Colors.white54),
          body1: base.body1.copyWith(
              fontSize: englishLike2018.body1.fontSize,
              fontWeight: englishLike2018.body1.fontWeight,
              letterSpacing: englishLike2018.body1.letterSpacing,
              textBaseline: englishLike2018.body1.textBaseline,
              color: type != ThemeType.Accent && type != ThemeType.Primary
                  ? onSurfaceColor
                  : type != ThemeType.Accent ? onPrimaryColor : onAccentColor),
          body2: base.body2.copyWith(
              fontSize: englishLike2018.body2.fontSize,
              fontWeight: englishLike2018.body2.fontWeight,
              letterSpacing: englishLike2018.body2.letterSpacing,
              textBaseline: englishLike2018.body2.textBaseline,
              color: type != ThemeType.Accent && type != ThemeType.Primary
                  ? onSurfaceColor
                  : type != ThemeType.Accent ? onPrimaryColor : onAccentColor),
          subhead: base.subhead.copyWith(
            fontSize: englishLike2018.subhead.fontSize,
            fontWeight: englishLike2018.subhead.fontWeight,
            letterSpacing: englishLike2018.subhead.letterSpacing,
            textBaseline: englishLike2018.subhead.textBaseline,
            color: type != ThemeType.Accent && type != ThemeType.Primary
                ? onSurfaceColor
                : type != ThemeType.Accent ? onPrimaryColor : onAccentColor,
          ))
      .apply(
        fontFamily: 'Spectral',
      );
}

const TextTheme englishLike2018 = TextTheme(
  display4: TextStyle(
      debugLabel: 'englishLike display4 2018',
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: -1.5),
  display3: TextStyle(
      debugLabel: 'englishLike display3 2018',
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: -0.5),
  display2: TextStyle(
      debugLabel: 'englishLike display2 2018',
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.0),
  display1: TextStyle(
      debugLabel: 'englishLike display1 2018',
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.25),
  headline: TextStyle(
      debugLabel: 'englishLike headline 2018',
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.0),
  title: TextStyle(
      debugLabel: 'englishLike title 2018',
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.15),
  subhead: TextStyle(
      debugLabel: 'englishLike subhead 2018',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.15),
  body2: TextStyle(
      debugLabel: 'englishLike body2 2018',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.25),
  body1: TextStyle(
      debugLabel: 'englishLike body1 2018',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.5),
  button: TextStyle(
      debugLabel: 'englishLike button 2018',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.75),
  caption: TextStyle(
      debugLabel: 'englishLike caption 2018',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.4),
  subtitle: TextStyle(
      debugLabel: 'englishLike subtitle 2018',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 0.1),
  overline: TextStyle(
      debugLabel: 'englishLike overline 2018',
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      textBaseline: TextBaseline.alphabetic,
      letterSpacing: 1.5),
);
