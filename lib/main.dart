import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_playground/lego_things/main.dart';
import 'package:flutter_playground/pages/lego_things/app.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/app.dart';
import 'package:flutter_playground/pages/masterpieces/main.dart';
import 'package:flutter_playground/pages/toys/main.dart';
import 'package:flutter_playground/routes.dart';
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemUiOverlayStyle _customOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: null,
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(_customOverlayStyle);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) async {
    print('${rec.level.name}: (${rec.loggerName}) ${rec.time}: ${rec.message}');

    var logFile = File("/data/data/com.example.flutterplayground/app.log");
    var sink = logFile.openWrite(mode: FileMode.append);
    sink.write("[${rec.level.name}] (${rec.loggerName}) ${rec.time}: ${rec.message}\n");
    await sink.flush();
    await sink.close();
  });
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Playground',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        PlaygroundRoutes.home: (context) => HomePage(),
        PlaygroundRoutes.legoThings: (context) => LegoThingsExample(),
        PlaygroundRoutes.toys: (context) => ToysPage(),
        PlaygroundRoutes.masterpieces: (context) => MasterpiecesPage(),
      },
      localizationsDelegates: [
        FlutterI18nDelegate(
            useCountryCode: false, fallbackFile: 'en_US', path: 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Locale _currentLang;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await FlutterI18n.refresh(context, Locale('en_US'));
      setState(() {
        _currentLang = FlutterI18n.currentLocale(context);
        print(_currentLang);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> elements = [
      {
        "name": FlutterI18n.translate(context, "homePage.legoThings"),
        "routeTo": "/lego-things",
        "img": "assets/images/playground/mark-seletcky.jpg"
      },
      {
        "name": FlutterI18n.translate(context, "homePage.toys"),
        "routeTo": "/toys",
        "img": "assets/images/playground/maksym-kaharlytskyi.jpg"
      },
      {
        "name": FlutterI18n.translate(context, "homePage.masterpieces"),
        "routeTo": "/masterpieces",
        "img": "assets/images/playground/raychan.jpg"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "homePage.title")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              String selectedLang = await showDialog(
                context: context,
                builder: (context) => LanguageSettingsDialog(
                      currentSelectedLang: _currentLang.languageCode,
                    ),
              );
              setState(() {
                _currentLang = Locale(selectedLang);
              });
              await FlutterI18n.refresh(context, _currentLang);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
//            SizedBox(
//              height: kToolbarHeight,
//              child: AppBar(
//                title: Text(FlutterI18n.translate(context, "homePage.title")),
//              ),
//            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.only(top: 8.0),
                itemBuilder: (context, index) {
                  return FeatureCard(
                    title: elements[index]["name"],
                    bgImage: Image.asset(
                      elements[index]["img"],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => Navigator.pushNamed(
                        context, elements[index]["routeTo"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSettingsDialog extends StatefulWidget {
  final String currentSelectedLang;

  const LanguageSettingsDialog({Key key, this.currentSelectedLang})
      : super(key: key);

  @override
  LanguageSettingsDialogState createState() => LanguageSettingsDialogState();
}

class LanguageSettingsDialogState extends State<LanguageSettingsDialog> {
  String _selectedLang;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedLang = widget.currentSelectedLang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          FlutterI18n.translate(context, "homePage.languageSettings.title")),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<String>(
              value: "en_US",
              title: Text("English"),
              groupValue: _selectedLang,
              onChanged: _changeLang,
            ),
            RadioListTile<String>(
              value: "zh_TW",
              title: Text("繁體中文"),
              groupValue: _selectedLang,
              onChanged: _changeLang,
            ),
            RadioListTile<String>(
              value: "zh_CN",
              title: Text("简体中文"),
              groupValue: _selectedLang,
              onChanged: _changeLang,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(FlutterI18n.translate(context, "commonUse.cancel")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(FlutterI18n.translate(context, "commonUse.confirm")),
          onPressed: () {
            print("Now select: $_selectedLang");
            Navigator.pop(context, _selectedLang);
          },
        ),
      ],
    );
  }

  _changeLang(value) {
    setState(() {
      _selectedLang = value;
    });
  }
}
