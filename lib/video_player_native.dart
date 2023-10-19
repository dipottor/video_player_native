
import 'video_player_native_platform_interface.dart';

class VideoPlayerNative {
  Future<String?> getPlatformVersion() {
    return VideoPlayerNativePlatform.instance.getPlatformVersion();
  }
}
