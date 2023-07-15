import '../Services/api_service.dart';
import '../Services/wallpaper_model.dart';

class WallpaperRepo{

  Future<WallpaperModel> getTrendingWallpaper({String? perPage, String? pageNo}) async{
    var url = '?key=29478997-d6a6371eb641864f24b1b39e3&q=yellow+flowers&image_type=photo&per_page=${perPage ?? 25}&page=${pageNo ?? 1}';
    var jsonRes = await APIService().getWallpaper(myUrl: url);
    return WallpaperModel.fromJson(jsonRes);
  }
}