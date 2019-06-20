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
            "http://localhost:5000/file?name=304.mp4",
            "http://localhost:5000/file?name=UCCU.jpg",
            "http://localhost:5000/file?name=UnderworldEvolutionWEBM.webm",
            "http://localhost:5000/file?name=%E8%88%89%E5%80%8B%E6%A0%97%E5%AD%90.jpeg",
            "http://localhost:5000/file?name=%E9%BB%91%E4%BA%BA%E5%95%8F%E8%99%9F.gif",
            "http://localhost:5000/file?name=15超人特攻隊.mp4"
          ],
          // playList: [
          //   "http://176.122.189.197:8001/304.mp4",
          //   "http://176.122.189.197:8001/UCCU.jpg",
          //   "http://176.122.189.197:8001/Merged_%E8%BB%8A%E5%8B%9D%E5%85%83-_%E8%BB%8A%E5%8B%9D%E5%85%83-_%E5%AE%8B%E4%BB%B2%E5%9F%BA-S.mp4",
          //   "http://176.122.189.197:8001/%E8%88%89%E5%80%8B%E6%A0%97%E5%AD%90.jpeg",
          //   "http://176.122.189.197:8001/%E9%BB%91%E4%BA%BA%E5%95%8F%E8%99%9F.gif",
          //   "http://176.122.189.197:8001/big-buck-bunny_trailer.webm"
          // ],
        ),
      ),
    );
  }
}