import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  final List<int> numbers;
  final Color keyButtonColor;
  final KeyButtonStyle keyButtonStyle;
  final Function onInsert, onRevert, onClear, onComplete;

  const KeyPad({
    Key key,
    this.numbers,
    this.keyButtonColor,
    this.keyButtonStyle,
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
            .map((value) => KeyPadButton(
                  style: keyButtonStyle,
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
            child: KeyPadButton(
              style: keyButtonStyle,
              child: Icon(Icons.backspace),
              onPressed: onRevert,
            ),
          ),
          KeyPadButton(
            style: keyButtonStyle,
            child: Text(numbers.last.toString()),
            onPressed: () => onInsert(numbers.last.toString()),
          ),
          KeyPadButton(
            style: keyButtonStyle,
            child: Icon(Icons.send),
            onPressed: onComplete,
          ),
        ],
      ),
    );
  }
}

class KeyPadButton extends StatelessWidget {
  const KeyPadButton({
    Key key,
    this.backgroundColor,
    this.style,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final Color backgroundColor;
  final KeyButtonStyle style;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawMaterialButton(
      fillColor: backgroundColor ?? theme.buttonColor,
      elevation: style == KeyButtonStyle.raised ? 2.0 : 0.0,
      highlightElevation: style == KeyButtonStyle.raised ? 8.0 : 0.0,
      child: child,
      onPressed: onPressed,
    );
  }
}

enum KeyButtonStyle { flat, raised }
