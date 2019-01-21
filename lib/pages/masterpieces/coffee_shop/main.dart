import 'package:flutter/material.dart';

import 'package:flutter_playground/pages/masterpieces/coffee_shop/home.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/menu.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CoffeeShop extends StatefulWidget {
  @override
  CoffeeShopState createState() {
    return new CoffeeShopState();
  }
}

class CoffeeShopState extends State<CoffeeShop> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Home(),
    Menu(),
    Text('Index 2: Order'),
    Text('Index 3: Cart'),
    Text('Index 4: User'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop App'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
              icon: Icon(Icons.shopping_cart), title: Text('Cart')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('User')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
