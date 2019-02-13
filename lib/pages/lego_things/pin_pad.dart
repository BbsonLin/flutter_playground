import 'package:flutter/material.dart';
import 'package:flutter_playground/lego_things/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PinPadExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PinPad(
          padding: EdgeInsets.only(top: 64.0),
          randomKeys: false,
          onComplete: (pinNumber) {
            Fluttertoast.showToast(msg: "You entered $pinNumber.");
          },
        ),
      ),
    );
  }
}
