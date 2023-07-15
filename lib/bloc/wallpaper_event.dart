part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent{}

class GetTrendingWallpaperEvent extends WallpaperEvent{
  String? perPage;
  String? pageNo;
  GetTrendingWallpaperEvent({this.perPage, this.pageNo});
}
