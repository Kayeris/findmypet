import 'package:findmypet/screens/explore.dart';

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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );

    final passwordField = Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );

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
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.0),
              Text(
                'Find My Pet',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 45.0,
                  color: const Color(0xFFE0E0E0),
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: Container(
                  height: 250.0,
                  width: (MediaQuery.of(context).size.width - 20) / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(height: 30.0),
              emailField,
              SizedBox(height: 15.0),
              passwordField,
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('SIGN IN'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExploreScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
