import 'package:flutter/services.dart';
import 'package:flutter_playground/pages/lego_things/feature_card.dart';
import 'package:flutter_playground/pages/lego_things/main.dart';
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
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Playground',
      theme: ThemeData(
          primaryColor: Colors.white,
          buttonColor: Colors.deepPurple,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.deepPurple,
          ),
          bottomAppBarColor: Colors.deepPurple,
          inputDecorationTheme:
              InputDecorationTheme(fillColor: Colors.deepPurple)),
      routes: {
        PlaygroundRoutes.home: (context) => HomePage(),
        PlaygroundRoutes.legoThings: (context) => LegoThingsPage(),
        PlaygroundRoutes.toys: (context) => ToysPage(),
        PlaygroundRoutes.masterpieces: (context) => MasterpiecesPage(),
      },
    ),
  );
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
        /*
        ListView(
          children: <Widget>[
            ListTile(
              title: Text("Lego Things"),
              onTap: () => Navigator.pushNamed(context, "/lego-things"),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text('Animation Example'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimationExample(),
                  )),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text('Add To Animation'),
              onTap: () => router.push(context, "myapp://toys/add_to_cart"),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text('Swagger Animation Page'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaggerDemo(),
                  )),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text('Custom Action Button'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomActionPage(),
                  )),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text('Coffee Shop App'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeShop(),
                  )),
            )
          ],
        ),
        */
      ),
    );
  }
}
