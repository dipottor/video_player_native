import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_player_native_method_channel.dart';

abstract class VideoPlayerNativePlatform extends PlatformInterface {
  /// Constructs a VideoPlayerNativePlatform.
  VideoPlayerNativePlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoPlayerNativePlatform _instance = MethodChannelVideoPlayerNative();

  /// The default instance of [VideoPlayerNativePlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoPlayerNative].
  static VideoPlayerNativePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoPlayerNativePlatform] when
  /// they register themselves.
  static set instance(VideoPlayerNativePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
