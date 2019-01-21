import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final Image bgImage;
  final Function onTap;

  const FeatureCard({Key key, this.title, this.bgImage, this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: bgImage,
          ),
          Container(
            height: 100.0,
            alignment: Alignment.bottomLeft,
            color: Color(0x88303030),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
