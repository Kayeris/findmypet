/// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is the main application widget.
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        scaffoldBackgroundColor: const Color(0xFF91BDF3),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFFB9D88),
          ),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Find My Pet',
                style: TextStyle(
                  fontFamily: 'Surfer',
                  fontSize: 50.0,
                  color: const Color(0xFFE0E0E0),
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset('images/zj-cubed.png'),
              ElevatedButton(
                child: Text('SIGN IN'),
                onPressed: () {
                  print('Pressed');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
