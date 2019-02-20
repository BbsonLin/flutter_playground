import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final double buttonSize;
  final num countValue;
  final int decimalPlaces;
  final num minValue;
  final num maxValue;
  final num step;
  final Function(num value) onChanged;

  const Counter({
    Key key,
    @required num initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.buttonSize,
    this.decimalPlaces = 0,
    this.step = 1,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        countValue = initialValue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CountButton(
            size: buttonSize,
            shape: CircleBorder(),
            icon: Icon(Icons.remove),
            onTap: _decreaseCount,
          ),
          Container(
            alignment: Alignment.center,
            width: 24.0,
            child: Text(
                "${num.parse((countValue).toStringAsFixed(decimalPlaces))}"),
          ),
          CountButton(
            size: buttonSize,
            shape: CircleBorder(),
            icon: Icon(Icons.add),
            onTap: _increaseCount,
          ),
        ],
      ),
    );
  }

  void _increaseCount() {
    if (countValue + step <= maxValue) {
      onChanged((countValue + step));
    }
  }

  void _decreaseCount() {
    if (countValue - step >= minValue) {
      onChanged((countValue - step));
    }
  }
}

class CountButton extends StatelessWidget {
  const CountButton({
    Key key,
    this.size,
    this.icon,
    this.shape,
    this.onTap,
  }) : super(key: key);

  final double size;
  final Icon icon;
  final ShapeBorder shape;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: size != null
          ? BoxConstraints(minWidth: size, minHeight: size)
          : BoxConstraints(),
      shape: shape,
      child: icon,
      onPressed: onTap,
    );
  }
}
