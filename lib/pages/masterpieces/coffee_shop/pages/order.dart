import 'package:flutter/material.dart';

import 'package:flutter_playground/pages/masterpieces/coffee_shop/pages/menu.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/state_container.dart';

class OrderPage extends StatefulWidget {
  @override
  OrderPageState createState() {
    return new OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  var total = 0.0;

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    container.orders.forEach((order) => total += order.subTotal);

    if (container.orders.length == 0) return NoOrderPage();
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: container.orders.length,
              itemBuilder: (context, index) {
                var order = container.orders[index];
                return ListTile(
                  title: Text(order.item.title),
                  subtitle: Text("Amount: ${order.count}"),
                  trailing: Text("\$ ${order.subTotal}"),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerRight,
            child: Column(
              children: <Widget>[
                Text(
                  "Total: \$ $total",
                ),
                RaisedButton(
                  child: Text("Checkout"),
                  onPressed: () {
                    container.cleanOrders();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("There's no order now"),
          RaisedButton(
            child: Text("Go shopping"),
            onPressed: () {
              container.bottomRouteTo(1);
            },
          )
        ],
      ),
    );
  }
}
