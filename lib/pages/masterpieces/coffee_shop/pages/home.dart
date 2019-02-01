import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatelessWidget {
  final List<String> imageUrls = [
    "https://bit.ly/2Fv0Xxz",
    "https://bit.ly/2TTbC8f",
    "https://bit.ly/2T0z3wk"
  ];

  final List<String> images = [
    "assets/images/coffee_shop/clem-onojeghuo.jpg",
    "assets/images/coffee_shop/kim-s-ly.jpg",
    "assets/images/coffee_shop/nathan-dumlao.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Swiper(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
              controller: SwiperController(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
//              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text('Order Now'),
                  ),
                ),
                Divider(height: 2.0),
                Expanded(
                  child: ListTile(
                    title: Text('Coffee Wallet'),
                  ),
                ),
                Divider(height: 2.0),
                Expanded(
                  child: ListTile(
                    title: Text('Share & Get one free'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
