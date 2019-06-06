import 'package:flutter/material.dart';
import 'package:flutter_playground/lego_things/ad_player/ad_player.dart';

class AdPlayerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AdPlayer Example"),),
      body: Center(
        child: AdPlayer(
          playList: [
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            "http://176.122.189.197:8001/UCCU.jpg",
            "http://176.122.189.197:8001/%E8%88%89%E5%80%8B%E6%A0%97%E5%AD%90.jpeg",
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            "http://176.122.189.197:8001/%E9%BB%91%E4%BA%BA%E5%95%8F%E8%99%9F.gif",
          ],
        ),
      ),
    );
  }
}