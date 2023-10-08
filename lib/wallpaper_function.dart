import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter/services.dart';

Future<void> setWallpaper(String imageUrl, String screen) async {
  try {
    var cachedImage = await DefaultCacheManager().getSingleFile(imageUrl);
    // final bool result = await WallpaperManager.setWallpaperFromFile(
    //   cachedImage.path,
    //   WallpaperManager.HOME_SCREEN,
    // );
    final myPlatformChannel = MethodChannel('myChannelName');
    final result2 =
        myPlatformChannel.invokeMethod("setWallpaper", [cachedImage.path, 0]);

    // print(result);
    print(result2);
  } catch (err) {
    print("error: $err");
  }
}
