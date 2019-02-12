import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  final List<int> numbers;
  final Function onInsert, onRevert, onClear, onComplete;

  const KeyPad({
    Key key,
    this.numbers,
    this.onInsert,
    this.onRevert,
    this.onClear,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _numberRow(numbers.sublist(0, 3)),
          _numberRow(numbers.sublist(3, 6)),
          _numberRow(numbers.sublist(6, 9)),
          _lastRow(),
        ],
      ),
    );
  }

  _numberRow(List<int> inputs) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: inputs
            .map((value) => MaterialButton(
          child: Text(value.toString()),
          onPressed: () => onInsert(value.toString()),
        ))
            .toList(),
      ),
    );
  }

  _lastRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onLongPress: onClear,
            child: MaterialButton(
              child: Icon(Icons.backspace),
              onPressed: onRevert,
            ),
          ),
          MaterialButton(
            child: Text(numbers.last.toString()),
            onPressed: () => onInsert(numbers.last.toString()),
          ),
          MaterialButton(
            child: Icon(Icons.send),
            onPressed: onComplete,
          ),
        ],
      ),
    );
  }
}
