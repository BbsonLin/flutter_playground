import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

Logger log = Logger('VideoPlaying');

class VideoPlaying extends StatefulWidget {
  @override
  VideoPlayingState createState() => VideoPlayingState();
}

class VideoPlayingState extends State<VideoPlaying> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // _videoController = VideoPlayerController.network(widget.sourceUrl);
    _videoController = VideoPlayerController.asset("assets/videos/sample.mp4");
    _videoController.setVolume(1.0);
    _videoController.setLooping(true);
    _videoController.initialize();
    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(child: VideoPlayer(_videoController)),
    );
  }
}
