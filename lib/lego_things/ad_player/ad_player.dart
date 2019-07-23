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

  @override
  void dispose() {
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
              if (widget.playList.length > 1) {
                Future.delayed(Duration(seconds: 10), () {
                  _nextPlay();
                });
              }
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
      if (widget.playList.length == 1) _videoController.setLooping(true);
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
    int pos = _videoController.value.position.inMilliseconds;
    int dur = _videoController.value.duration.inMilliseconds;
    if (widget.playList.length > 1 && dur - pos < 1) {
      log.fine("position: $pos, duration: $dur");
      _nextPlay();
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
  }

  Future<bool> _clearPrevious() async {
    await _videoController?.seekTo(Duration(milliseconds: 0));
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    return true;
  }
}
