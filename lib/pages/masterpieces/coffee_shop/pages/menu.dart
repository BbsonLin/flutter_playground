import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/state_container.dart';

class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() {
    return new MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {
  StateContainerState container;
  GlobalKey<ScaffoldState> _menuKey = GlobalKey<ScaffoldState>();
  MenuType selectedCat;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    container = StateContainer.of(context);
    return Scaffold(
      key: _menuKey,
      body: LayoutBuilder(builder: _buildStack),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 3 / 5,
        child: Drawer(
          child: Column(
            children: container.categories.map((cat) {
              return ListTile(
                title: Text(cat.title),
                onTap: () {
                  setState(() {
                    selectedCat = cat;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "category",
        child: Icon(Icons.menu),
        onPressed: () {
          _menuKey.currentState.openEndDrawer();
        },
      ),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    var content = container.menus.where((m) {
      if (selectedCat == null || selectedCat.value == "all") {
        return true;
      }
      return (m.type.value == selectedCat.value);
    }).toList();
    return SingleChildScrollView(
      child: Column(
        children: content.map((item) {
          var order = container.orders.firstWhere((o) => (o.item == item), orElse: () => null);
          return MenuCard(
            title: Text(item.title),
            subtitle: Text("\$ ${item.price}"),
            count: order == null ? 0 : order.count,
            onCountChange: (num value) {
              print(value);
              container.updateOrders(item: item, updateCount: value);
            },
          );
        }).toList(),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final int count;
  final Function onCountChange;

  const MenuCard({
    Key key,
    this.title,
    this.subtitle,
    this.count,
    this.onCountChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: this.title,
        subtitle: this.subtitle,
        trailing: Counter(
          minValue: 0,
          maxValue: 10,
          initialValue: this.count,
          decimalPlaces: 0,
          onChanged: this.onCountChange,
          buttonSize: 24,
        ),
      ),
    );
  }
}
