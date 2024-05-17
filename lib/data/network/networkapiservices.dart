import 'dart:convert';
import 'dart:io';
import 'package:mvvm/data/appexceptions.dart';
import 'package:mvvm/data/network/baseapiservices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url,{Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url),headers: headers).timeout(const Duration(seconds: 10));
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
           return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with the server, with status code: ${response.statusCode.toString()}');
    }
  }
}

