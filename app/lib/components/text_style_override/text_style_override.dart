import 'package:flutter/material.dart';

class TextStyleOverride extends StatelessWidget {
  const TextStyleOverride({Key key, this.textStyle, this.child})
      : super(key: key);
  final TextStyle textStyle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
          textTheme: localTheme.textTheme.copyWith(
              headline: localTheme.textTheme.headline.merge(textStyle),
              title: localTheme.textTheme.title.merge(textStyle),
              caption: localTheme.textTheme.caption.merge(textStyle),
              subhead: localTheme.textTheme.subhead.merge(textStyle),
              body1: localTheme.textTheme.body1.merge(textStyle),
              body2: localTheme.textTheme.body2.merge(textStyle))),
    );
  }
}
