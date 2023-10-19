import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_player_native_platform_interface.dart';

class MethodChannelVideoPlayerNative extends VideoPlayerNativePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('video_player_native');

  @override
  Future<String?> networkUri(String contentUrl) async {
    final version = await methodChannel
        .invokeMethod<String>('getPlatformVersion', {'data': contentUrl});
    return version;
  }
}
