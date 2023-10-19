
import 'video_player_native_platform_interface.dart';

class VideoPlayerNative {
  Future<String?> networkUri(String contentUrl) {
    return VideoPlayerNativePlatform.instance.networkUri(contentUrl);
  }
}


