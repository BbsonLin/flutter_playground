import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NowTime extends StatefulWidget {
  @override
  NowTimeState createState() => NowTimeState();
}

class NowTimeState extends State<NowTime> {
  Timer _nowTimer;
  String _timeString;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _nowTimer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    _nowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.tightForFinite(),
      child: Text(
        _timeString,
        textAlign: TextAlign.center,
        softWrap: false,
        style: Theme.of(context).primaryTextTheme.subhead,
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy/MM/dd\nHH:mm").format(dateTime);
  }
}
