import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_api/repositary/repo.dart';

import 'bloc/wallpaper_bloc.dart';
import 'Screens/home_page.dart';

void main(){
  runApp(
      BlocProvider(create: (context) => WallpaperBloc(repo: WallpaperRepo()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

