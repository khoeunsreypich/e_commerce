import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiServicePag {
  Future<dynamic> getApiPag(String url, {Map<String, String>? queryParams}) async {
    http.StreamedResponse? response;
    try {
      var uri = Uri.parse(url).replace(queryParameters: queryParams);
      print('Request URL: $uri'); // Debug print

      var request = http.Request('GET', uri);
      response = await request.send();

      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        String responseStr = await response.stream.bytesToString();
        print('Response Body: $responseStr'); // Debug print
        return responseStr;
      } else {
        print('Error Response Body: ${await response.stream.bytesToString()}'); // Debug print
        throw FetchDataException('Error occurred with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
  @override
  String toString() => message;
}
