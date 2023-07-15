import 'package:flutter/material.dart';

class WallpaperFullScreen extends StatelessWidget {
  String imgUrl;

  WallpaperFullScreen({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: Image.network(imgUrl, fit: BoxFit.fitHeight),
        ),
        Positioned(
          top: 25,
          left: 20,
          child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_back,color: Colors.white,))),
        )
      ],
    ));
  }
}
