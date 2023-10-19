import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_player_native_platform_interface.dart';

/// An implementation of [VideoPlayerNativePlatform] that uses method channels.
class MethodChannelVideoPlayerNative extends VideoPlayerNativePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_player_native');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
