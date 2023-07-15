// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import 'Services/api_service.dart';
// import 'Services/wallpaper_model.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   late Future<WallpaperModel> arr;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//   getData() async {
//     arr = (await ApiClient()) as Future<WallpaperModel>;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(arr);
//     return Scaffold(
//       body:Container(),
//     );
//   }
//
//   Future<WallpaperModel> ApiClient() async {
//     String url =
//         "https://pixabay.com/api/?key=29478997-d6a6371eb641864f24b1b39e3&q=yellow+flowers&image_type=photo&page=1&per_page=10";
//     var jsonRes = await APIService().getWallpaper(myUrl: url);
//     return WallpaperModel.fromJson(jsonRes);
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:pixabay_api/Screens/wallpaper_full_screen.dart';
import '../Services/wallpaper_model.dart';
import '../bloc/wallpaper_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<WallpaperModel> users;
  late WallpaperModel wallpapers;
  int page = 1;
  int perPage=10;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaperEvent(pageNo: '1', perPage: '${perPage}'));
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper'),
        centerTitle: true,
      ),
      body: BlocBuilder<WallpaperBloc, WallpaperState>(
        builder: (context, state) {
          if(state is WallpaperLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is WallpaperLoadedState){
            wallpapers = state.wallpapers;
            return SingleChildScrollView(

              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wallpapers.hits!.length,
                    itemBuilder: (context, index) {
                      print(wallpapers.hits!.length);
                      var image = wallpapers.hits![index].largeImageURL!;
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperFullScreen(imgUrl: image.toString()),));
                        },
                        child:Container(
                          height: height*0.3,
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(image.toString()),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      );
                    },),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: (){
                        perPage += 10;
                        BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaperEvent(perPage: '$perPage', pageNo: '$page'));
                      },
                      child: const Text('Load More...', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ))),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          } if(state is WallpaperErrorState) {
            return Center(child: Text(state.error.toString()),);
          } else{
            return Container();
          }
        },
      ),
    );
  }
  Future<WallpaperModel> getUserData()async {
    var url='https://pixabay.com/api/?key=29478997-d6a6371eb641864f24b1b39e3&q=yellow+flowers&image_type=photo&page=1&per_page=20';
    var response =await httpClient.get(Uri.parse(url));

    print(response.statusCode);

    if(response.statusCode == 200){
      return WallpaperModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      print('failed...........................');
      return WallpaperModel();
    }

  }
}


