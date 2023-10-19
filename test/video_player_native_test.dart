import 'package:flutter_test/flutter_test.dart';
import 'package:video_player_native/video_player_native.dart';
import 'package:video_player_native/video_player_native_platform_interface.dart';
import 'package:video_player_native/video_player_native_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVideoPlayerNativePlatform
    with MockPlatformInterfaceMixin
    implements VideoPlayerNativePlatform {

  @override
  Future<String?> networkUri(String contentUrl) => Future.value('42');
}

void main() {
  final VideoPlayerNativePlatform initialPlatform = VideoPlayerNativePlatform.instance;

  test('$MethodChannelVideoPlayerNative is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVideoPlayerNative>());
  });

  test('getPlatformVersion', () async {
    VideoPlayerNative videoPlayerNativePlugin = VideoPlayerNative();
    MockVideoPlayerNativePlatform fakePlatform = MockVideoPlayerNativePlatform();
    VideoPlayerNativePlatform.instance = fakePlatform;

    expect(await videoPlayerNativePlugin.networkUri("abcd"), '42');
  });
}
