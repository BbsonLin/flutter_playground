import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/store.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/state_container.dart';

class CoffeeShopApp extends StatefulWidget {
  @override
  CoffeeShopAppState createState() {
    return new CoffeeShopAppState();
  }
}

class CoffeeShopAppState extends State<CoffeeShopApp> {
  @override
  Widget build(BuildContext context) {
    return StateContainer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo[800],
          accentColor: Colors.amber,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.indigo[800],
          ),
        ),
        home: CoffeeShop(),
      ),
    );
  }
}

class CoffeeShop extends StatefulWidget {
  @override
  CoffeeShopState createState() {
    return new CoffeeShopState();
  }
}

class CoffeeShopState extends State<CoffeeShop> {
  final Logger log = Logger('CoffeeShopState');
  StateContainerState container;

  @override
  Widget build(BuildContext context) {
    container = StateContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.store),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                print(context);
                return StorePage();
              }));
            },
          )
        ],
      ),
      body: Center(
        child: container.bottomRoutes.elementAt(container.bottomRouteIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), title: Text('Menu')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Order')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('User')),
        ],
        currentIndex: container.bottomRouteIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    log.fine('_onItemTapped ${container.bottomRoutes[index]}');
    container.bottomRouteTo(index);
  }
}
