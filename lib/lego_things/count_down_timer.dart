import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';

class CountDownTimer extends StatefulWidget {
  final int countDownTime;
  final Function onDone;

  const CountDownTimer({Key key, countDownTime, this.onDone})
      : this.countDownTime = countDownTime ?? 10,
        super(key: key);

  @override
  CountDownTimerState createState() {
    return new CountDownTimerState();
  }
}

class CountDownTimerState extends State<CountDownTimer> {
  CountDown cd;
  var sub;
  int remain;

  @override
  void initState() {
    super.initState();
    cd = CountDown(Duration(seconds: widget.countDownTime));
    remain = widget.countDownTime;
    sub = cd.stream.listen(null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sub.onData((Duration d) {
//      print(d.inSeconds);
      setState(() {
        remain = d.inSeconds;
      });
    });
    sub.onDone(widget.onDone);

    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.tightForFinite(),
      child: Text(
        "$remain",
        textAlign: TextAlign.center,
        style: Theme.of(context).primaryTextTheme.subhead,
      ),
    );
  }
}
