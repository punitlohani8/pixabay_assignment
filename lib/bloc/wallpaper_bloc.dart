import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../Services/wallpaper_model.dart';
import '../repositary/repo.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperRepo repo;
  WallpaperBloc({required this.repo}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaperEvent>((event, emit) async {
      emit(WallpaperLoadingState());
      var wallpapers = await repo.getTrendingWallpaper(
          perPage: event.perPage, pageNo: event.pageNo);
      emit(WallpaperLoadedState(wallpapers: wallpapers));
    });

  }
}
