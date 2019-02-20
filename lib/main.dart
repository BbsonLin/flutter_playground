import 'package:flutter/services.dart';
import 'package:flutter_playground/lego_things/main.dart';
import 'package:flutter_playground/pages/lego_things/app.dart';
import 'package:flutter_playground/pages/masterpieces/main.dart';
import 'package:flutter_playground/pages/toys/main.dart';
import 'package:flutter_playground/routes.dart';
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
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
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map> elements = [
    {
      "name": "Lego Things",
      "routeTo": "/lego-things",
      "img": "assets/images/playground/mark-seletcky.jpg"
    },
    {
      "name": "Toys",
      "routeTo": "/toys",
      "img": "assets/images/playground/maksym-kaharlytskyi.jpg"
    },
    {
      "name": "Masterpieces",
      "routeTo": "/masterpieces",
      "img": "assets/images/playground/raychan.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                title: Text("Flutter Playground"),
              ),
            ),
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
