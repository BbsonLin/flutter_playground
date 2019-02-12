import 'package:flutter/material.dart';

import 'key_pad.dart';

class PinPad extends StatefulWidget {
  final Widget title;
  final Widget display;
  final EdgeInsetsGeometry padding;
  final Function onComplete;

  const PinPad({
    Key key,
    this.title = const Text("Enter Pin"),
    this.display = const TextField(),
    this.padding, this.onComplete,
  }) : super(key: key);

  @override
  PinPadState createState() => PinPadState();
}

class PinPadState extends State<PinPad> {
  List<int> _numberSet;
  String _input = "";

  @override
  void initState() {
    super.initState();
    _numberSet = _genRandomNumberSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          widget.title,
//          widget.display,
          KeyPad(
            numbers: _numberSet,
            onInsert: _insert,
            onClear: _clear,
            onRevert: _revert,
            onComplete: widget.onComplete,
          ),
        ],
      ),
    );
  }

  _genRandomNumberSet() {
    var list = List<int>.generate(10, (int index) => index); // [0, 1, 4]
    list.shuffle();
    print(list);
    return list;
  }

  _insert(String value) {
    setState(() {
      _input += value;
    });
  }

  _clear() {
    setState(() {
      _input = "";
    });
  }

  _revert() {
    setState(() {
      if (_input.length == 0) {
        _input = "";
      } else {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }
}

class PinDisplay extends StatelessWidget {
  final displayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(controller: displayController, obscureText: true),
    );
  }
}
