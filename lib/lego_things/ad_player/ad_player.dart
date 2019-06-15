import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';
import 'package:mime/mime.dart';

Logger log = Logger("AdPlayer");

class AdPlayer extends StatefulWidget {
  final List playList;

  const AdPlayer({Key key, this.playList}) : super(key: key);

  @override
  _AdPlayerState createState() => _AdPlayerState();
}

class _AdPlayerState extends State<AdPlayer> {
  VideoPlayerController _videoController;
  int _playingIndex = 0;
  String _playingMimeType = "";
  bool _disposed = false;
  bool _isPlaying = false;
  bool _isEndPlaying = false;
  bool _prepareNextPlaying = false;

  @override
  void dispose() {
    _disposed = true;
    // In my case, sound is playing though controller was disposed.
    _videoController?.pause()?.then((_) {
      // dispose VideoPlayerController.
      _videoController?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _playView();
  }

  Widget _playView() {
    return FutureBuilder(
      future: _initializeAd(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        log.fine("FutureBuilder AsyncSnapshot: $snapshot");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          case ConnectionState.done:
            if (_playingMimeType.contains("video")) {
              _videoController.play();
              return AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              );
            } else if (_playingMimeType.contains("image")) {
              Future.delayed(Duration(seconds: 10), () {
                _nextPlay();
              });
              return AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(widget.playList[_playingIndex]),
              );
            } else {
              return Center(
                child: Text("This file is either video type nor image type."),
              );
            }
        }
      },
    );
  }

  Future<dynamic> _initializeAd() {
    _playingMimeType = lookupMimeType(widget.playList[_playingIndex]);
    log.fine(
        "Now playingIndex: $_playingIndex, playingMimeType: $_playingMimeType");
    if (_playingMimeType.contains("video")) {
      _videoController =
          VideoPlayerController.network(widget.playList[_playingIndex]);
      _videoController.addListener(_videoListener);
      return _videoController.initialize();
    } else if (_playingMimeType.contains("image")) {
      return Future.delayed(Duration(milliseconds: 0), () {
        return true;
      });
    } else {
      return null;
    }
  }

  Future<void> _videoListener() async {
    if (_videoController == null || _disposed) {
      return null;
    }

    if (!_videoController.value.initialized) {
      return null;
    }

    final position = await _videoController.position;
    final duration = _videoController.value.duration;
    final isPlaying = position.inMicroseconds < duration.inMicroseconds;
    final overPlaying = position.inMicroseconds > duration.inMicroseconds;
    final isEndPlaying =
        position.inMilliseconds > 0 && position.inSeconds == duration.inSeconds;

    // 需另外判斷 overPlaying 和 _prepareNextPlaying，以防跳過下一個播放的 video
    if ((_isPlaying != isPlaying && !overPlaying && !_prepareNextPlaying) || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      log.info("position: $position, duration: $duration");
      log.info(
          "$_playingIndex -----> isPlaying=$isPlaying / isCompletePlaying=$isEndPlaying");
      if (isEndPlaying) {
        // final isComplete = _playingIndex == _playList.length - 1;
        bool isComplete = false;
        if (isComplete) {
          log.info("played all!!");
        } else {
          _prepareNextPlaying = true;
          _nextPlay();
        }
      }
    }
  }

  void _nextPlay() async {
    if (_playingMimeType.contains("video")) {
      await _clearPrevious();
    }
    setState(() {
      _playingIndex = (_playingIndex + 1) % widget.playList.length;
      log.fine("nextPlayIndex: $_playingIndex");
    });
    _prepareNextPlaying = false;
  }

  Future<bool> _clearPrevious() async {
    await _videoController?.pause();
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    return true;
  }
}
