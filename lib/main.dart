import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'PickerButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        //AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ar', ''), // Arabic, no country code
      ],
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: "Cairo",
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        fontFamily: "Cairo",
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProjectPickerButton(
              text: 'Click to Test',
              type: PickerButtonType.dateTime,
            ),
          ],
        ),
      ),
    );
  }
}
