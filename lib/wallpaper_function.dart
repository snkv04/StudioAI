import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setWallpaper(String imageUrl, String screen) async {
  try {
    var cachedImage = await DefaultCacheManager().getSingleFile(imageUrl);
    await WallpaperManagerFlutter().setwallpaperfromFile(
      cachedImage,
      WallpaperManagerFlutter.HOME_SCREEN,
    );

    print("successfully set wallpaper");
  } catch (err) {
    print("error: $err");
  }
}
