import 'package:flutter/material.dart';
import 'package:flutter_playground/lego_things/now_time.dart';

class NowTimeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NowTime(),
      ),
    );
  }
}
