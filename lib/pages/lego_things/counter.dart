import 'package:flutter/material.dart';
import 'package:flutter_playground/lego_things/counter.dart';

class CounterExample extends StatefulWidget {
  @override
  CounterExampleState createState() {
    return new CounterExampleState();
  }
}

class CounterExampleState extends State<CounterExample> {
  num count = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: Scaffold(
        appBar: AppBar(title: Text("Counter Example"),),
        body: Center(
          child: Counter(
            initialValue: count,
            minValue: 0,
            maxValue: 10,
            onChanged: (value) {
              setState(() {
                count = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
