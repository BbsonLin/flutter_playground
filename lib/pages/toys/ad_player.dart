import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

Logger log = Logger("AdPlayer");

/// Suggested by Brownsoo Han
/// https://stackoverflow.com/questions/55466602/how-to-play-a-list-of-video-in-flutter?answertab=active#tab-top
class AdPlayer extends StatefulWidget {
  @override
  _AdPlayerState createState() => _AdPlayerState();
}

class _AdPlayerState extends State<AdPlayer> {
  List _playList = [
    // "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "http://localhost:5000/file?name=304.mp4",
    "http://localhost:5000/file?name=sample.mp4",
    "http://localhost:5000/file?name=sample2.mp4"
  ];

  VideoPlayerController _controller;
  ChewieController _chewieController; // custom ui
  Future<void> _initializeVideoPlayerFuture;

  // var _clips = List<PoseClip>(); // video list
  int _playingIndex = -1;
  bool _disposed = false;
  var _isPlaying = false;
  var _isEndPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlay(0);
  }

  @override
  void dispose() {
    _disposed = true;
    // By assigning Future is null,
    // prevent the video controller is using in widget before disposing that.
    _initializeVideoPlayerFuture = null;
    // In my case, sound is playing though controller was disposed.
    _controller?.pause()?.then((_) {
      // dispose VideoPlayerController.
      _controller?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _playView();
  }

  // play view area
  Widget _playView() {
    // FutureBuilder to display a loading spinner until finishes initializing
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _chewieController.play();
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Chewie(controller: _chewieController),
          );
        } else {
          return SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    _controller?.removeListener(_controllerListener);
    _controller?.dispose();
    return true;
  }

  Future<void> _startPlay(int index) async {
    log.fine("play ---------> $index");
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(index);
      });
    });
  }

  Future<void> _initializePlay(int index) async {
    // final file = await _localStorage.localFile(_clips[index].filePath());
    // print("file.exists: ${file.existsSync()}");
    // print("file.path: ${file.path}");
    // _controller = VideoPlayerController.file(file);
    _controller = VideoPlayerController.network(_playList[index]);
    _controller.addListener(_controllerListener);
    _chewieController = ChewieController(videoPlayerController: _controller);
    _initializeVideoPlayerFuture = _controller.initialize();

    setState(() {
      _playingIndex = index;
    });
  }

// tracking status
  Future<void> _controllerListener() async {
    if (_controller == null || _disposed) {
      return;
    }
    if (!_controller.value.initialized) {
      return;
    }
    final position = await _controller.position;
    // print(position);
    final duration = _controller.value.duration;
    // print(duration);
    final isPlaying = position.inMilliseconds < duration.inMilliseconds;
    // print(isPlaying);
    final isEndPlaying =
        position.inMilliseconds > 0 && position.inSeconds == duration.inSeconds;
    // print(isEndPlaying);

    if (_isPlaying != isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      log.fine(
          "$_playingIndex -----> isPlaying=$isPlaying / isCompletePlaying=$isEndPlaying");
      if (isEndPlaying) {
        // final isComplete = _playingIndex == _playList.length - 1;
        bool isComplete = false;
        if (isComplete) {
          log.fine("played all!!");
        } else {
          int _nextPlayingIndex = (_playingIndex + 1) % _playList.length;
          _startPlay(_nextPlayingIndex);
          // _startPlay(_playingIndex + 1);
        }
      }
    }
  }
}
