import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/app.dart';

class MasterpiecesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                title: Text("Masterpieces"),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Coffee Shop App"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CoffeeShopApp()),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
