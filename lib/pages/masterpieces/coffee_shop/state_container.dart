import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/home.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/menu.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/user.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/order.dart';

class MenuType {
  int id;
  String title;
  String value;

  MenuType(this.id, this.title, this.value);

  MenuType.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    value = json["value"];
  }

  @override
  String toString() {
    return "MenuType{id: $id, title: $title, value: $value}";
  }
}

class Menu {
  String title;
  double price;
  MenuType type;

  Menu(this.title, this.price, this.type);

  Menu.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    price = json["price"];
    type = MenuType.fromJson(json["type"]);
  }

  @override
  String toString() {
    return "Menu{title: $title, price: $price, type: $type}";
  }
}

class Order {
  Menu item;
  int count;

  Order(this.item, this.count);

  double get subTotal => this.item.price * this.count;
}

class StateContainer extends StatefulWidget {
  final Widget child;

  const StateContainer({Key key, this.child}) : super(key: key);

  @override
  StateContainerState createState() => StateContainerState();

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class StateContainerState extends State<StateContainer> {
  List<Order> orders = [];
  List<Menu> menus = [];
  List<MenuType> categories = [];
  List<Widget> bottomRoutes = [
    Home(),
    MenuPage(),
    OrderPage(),
    User(),
  ];
  int bottomRouteIndex = 0;

  @override
  void initState() {
    initMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      child: widget.child,
      data: this,
    );
  }

  initMenus() async {
    var menuData = json.decode(await _loadSeed("menu"));
    var menuTypeData = json.decode(await _loadSeed("menu_type"));
    setState(() {
      menus = menuData.map<Menu>((m) => Menu.fromJson(m)).toList();
      categories = menuTypeData.map<MenuType>((m) => MenuType.fromJson(m)).toList();
    });
  }

  updateOrders({item, updateCount}) {
    int index = orders.indexWhere((order) => order.item == item);
    if (index >= 0) {
      if (updateCount == 0) {
        setState(() {
          orders.removeAt(index);
        });
      } else {
        setState(() {
          orders[index].count = updateCount;
        });
      }
    } else {
      setState(() {
        orders.add(Order(item, updateCount));
      });
    }
  }

  cleanOrders() {
    setState(() {
      orders = [];
    });
  }

  bottomRouteTo(int index) {
    setState(() {
      bottomRouteIndex = index;
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  const _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        assert(child != null),
        super(key: key, child: child);

  static _InheritedStateContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedStateContainer)
        as _InheritedStateContainer;
  }

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

Future<String> _loadSeed(String seedName) async {
  return await rootBundle.loadString("assets/seeds/$seedName.json");
}
