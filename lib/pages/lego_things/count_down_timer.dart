import 'package:flutter/material.dart';
import 'package:flutter_playground/lego_things/count_down_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CountDownTimerExample extends StatefulWidget {
  @override
  CountDownTimerExampleState createState() {
    return new CountDownTimerExampleState();
  }
}

class CountDownTimerExampleState extends State<CountDownTimerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Count Down Timer Example"),
      ),
      body: Center(
        child: CountDownTimer(
          countDownTime: 6,
          onDone: () {
            Fluttertoast.showToast(msg: "Done!!!");
          },
        ),
      ),
    );
  }
}
