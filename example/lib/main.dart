import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:video_player_native/video_player_native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _videoPlayerNativePlugin = VideoPlayerNative();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:  ElevatedButton(onPressed: () async {
            try {
              String mp4Url =
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
              String mp3Url =
                  "https://storage.googleapis.com/exoplayer-test-media-0/Jazz_In_Paris.mp3";
              String stageUrl = "https://stage-upload-test.s3.ap-south-1.amazonaws.com/1100/master.m3u8";
              _platformVersion =
                  await _videoPlayerNativePlugin.networkUri(mp4Url) ?? 'Unknown platform version';
            } on PlatformException {
              _platformVersion = 'Failed to get platform version.';
            }
            print("ElevatedButton$_platformVersion");

          },child: const Text("Play Video"),),
        ),
      ),
    );
  }
}
