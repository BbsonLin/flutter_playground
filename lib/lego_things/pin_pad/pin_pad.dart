import 'package:flutter/material.dart';

import 'key_pad.dart';

class PinPad extends StatefulWidget {
  final Widget title;
  final EdgeInsetsGeometry padding;
  final bool pinVisible;
  final Color keyColor;
  final KeyButtonStyle keyStyle;
  final bool randomKeys;
  final Function(String) onComplete;

  const PinPad({
    Key key,
    this.title = const Text("Enter Pin"),
    this.padding,
    this.pinVisible = true,
    this.keyColor,
    this.keyStyle = KeyButtonStyle.raised,
    this.randomKeys = true,
    this.onComplete,
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
    _numberSet = _genNumberSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          widget.title,
          PinDisplay(
            displayText: _input,
            displayTextVisible: widget.pinVisible,
          ),
          KeyPad(
            numbers: _numberSet,
            keyButtonColor: widget.keyColor,
            keyButtonStyle: widget.keyStyle,
            onInsert: _insert,
            onClear: _clear,
            onRevert: _revert,
            onComplete: () {
              widget.onComplete(_input);
              setState(() {
                _input = "";
              });
            },
          ),
        ],
      ),
    );
  }

  _genNumberSet() {
    var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    if (widget.randomKeys) list.shuffle();
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
  final String displayText;
  final bool displayTextVisible;

  PinDisplay({this.displayText = "", this.displayTextVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width * 2 / 3,
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: displayText.split("").map((t) {
          return Text(
            displayTextVisible ? t.toString() : "*",
            style: Theme.of(context).textTheme.title,
          );
        }).toList(),
      ),
    );
  }
}
