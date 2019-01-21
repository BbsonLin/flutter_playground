import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Swiper(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  "http://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
              controller: SwiperController(),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  title: Text('Order Now'),
                ),
                Divider(height: 0.0),
                ListTile(
                  title: Text('Coffee Wallet'),
                ),
                Divider(height: 0.0),
                ListTile(
                  title: Text('Share & Get one free'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
