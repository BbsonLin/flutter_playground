import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        autoplay: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}

