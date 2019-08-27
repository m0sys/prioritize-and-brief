import 'package:flutter/material.dart';

class DebriefLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get theme instance
    ThemeData localTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Debrief Me!",
                style: localTheme.textTheme.title
                    .copyWith(fontSize: 48)
                    .apply(fontFamily: 'Elsie')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.book,
              color: localTheme.accentColor,
              size: 48,
            ),
          )
        ],
      ),
    );
  }
}
