import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exception.dart';
class ApiService {
  Future<dynamic> getApi(url) async{
    http.StreamedResponse? response;
    try{
      var request = http.Request('GET',Uri.parse(url));
      response= await request.send();
      return returnResponse(response);
    }on SocketException{
      throw  FetchDataException(response!.reasonPhrase.toString());
    }
  }


  Future<dynamic> uploadImage (image,url) async{
    http.StreamedResponse? response;
    try{
      var request = http.MultipartRequest('POST',Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('files',image));
      response = await request.send();
      return returnResponse(response);
    }on Exception{
      throw FetchDataException(response!.reasonPhrase);
    }
  }

  Future<dynamic> postProduct (url,data) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request =  http.Request( 'POST', Uri.parse(url));
    request.body=data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      return true;
    }
    else {
     // print(response.reasonPhrase);
      return false;
    }
  }
  Future<dynamic> postCategory (url,data) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
      // print(response.reasonPhrase);
    }
  }
  Future<dynamic> updateProduct (url,data,bool isUpdate) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    //var request =  http.Request( isUpdate? 'PUT':'POST', Uri.parse(url));
    var request =  http.Request('PUT', Uri.parse(url));
    request.body=data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return true;
    }
    else {
      // print(response.reasonPhrase);
      return false;
    }
  }
  Future<dynamic> deleteProduct(url) async{
    var request = http.Request('DELETE', Uri.parse(url));
    var response =await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

   returnResponse(http.StreamedResponse response) async {
   //  print('response ${response.reasonPhrase}');
    // print('response ${response.stream.bytesToString()}');
     switch (response.statusCode) {
       case 200:
         return await response.stream.bytesToString();
       case 500:
       case 404:
     }
   }
   }


