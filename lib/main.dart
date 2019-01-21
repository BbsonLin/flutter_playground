import 'package:flutter_playground/pages/lego_things/feature_card.dart';
import 'package:flutter_playground/pages/lego_things/main.dart';
import 'package:flutter_playground/pages/masterpieces/main.dart';
import 'package:flutter_playground/pages/toys/main.dart';
import 'package:flutter_playground/routes.dart';
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';

import 'package:flutter_playground/pages/toys/swiper_image.dart';
import 'package:flutter_playground/pages/toys/animation_example.dart';
import 'package:flutter_playground/pages/toys/stagger_animation.dart';
import 'package:flutter_playground/pages/toys/add_to_cart.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/main.dart';
import 'package:flutter_playground/pages/toys/custom_action_button.dart';
import 'package:flutter_playground/router.dart';
import 'package:flutter_playground/router.internal.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  runApp(
    MaterialApp(
        title: 'Flutter Playground',
//        home: HomePage(),
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          buttonColor: Colors.deepPurple,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.deepPurple,
          ),
        ),
        routes: {
          PlaygroundRoutes.home: (context) => HomePage(),
          PlaygroundRoutes.legoThings: (context) => LegoThingsPage(),
          PlaygroundRoutes.toys: (context) => ToysPage(),
          PlaygroundRoutes.masterpieces: (context) => MasterpiecesPage(),
        }),
  );
}

class HomePage extends StatelessWidget {
  final router = Router();
  final List<Map> elements = [
    {"name": "Lego Things", "routeTo": "/lego-things", "img": "https://bit.ly/2HnmE4n"},
    {"name": "Toys", "routeTo": "/toys", "img": "https://bit.ly/2FFqO62"},
    {"name": "Masterpieces", "routeTo": "/masterpieces", "img": "https://bit.ly/2sCwtRN"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Playground"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.only(top: 8.0),
          itemBuilder: (context, index) {
            return FeatureCard(
              title: elements[index]["name"],
              bgImage: Image.network(
                elements[index]["img"],
                fit: BoxFit.cover,
              ),
              onTap: () =>
                  Navigator.pushNamed(context, elements[index]["routeTo"]),
            );
          },
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
