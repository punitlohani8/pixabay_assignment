import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as httpClint;

import 'api_exception.dart';

class APIService{
  String baseUrl = "https://pixabay.com/api/";


  Future<dynamic> getWallpaper({required String myUrl,}) async{
    try{
      var res = await httpClint.get(Uri.parse('$baseUrl$myUrl'));
      return checkResponse(res);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }

  }
  dynamic checkResponse(httpClint.Response res){
    switch(res.statusCode){
      case 200:
        var jsonResponse = json.decode(res.body.toString());
        return jsonResponse;
      case 400:
        throw BadRequestException(res.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(res.body.toString());
      case 429:
        throw FetchDataException(
            'API rate limit exceeded with StatusCode : ${res.statusCode.toString()}'
        );
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server with StatusCode : ${res.statusCode.toString()}'
        );
    }
  }
}

