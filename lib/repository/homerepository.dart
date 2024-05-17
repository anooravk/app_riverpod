import 'dart:convert';
import 'package:mvvm/data/network/baseapiservices.dart';
import 'package:mvvm/data/network/networkapiservices.dart';
import 'package:mvvm/model/moviesmodel.dart';
import 'package:http/http.dart' as http;
import '../resources/components/appurls.dart';

class HomeRepository {
  BaseApiService apiService = NetworkApiService();

  Future<MoviesModel> fetchMoivesList() async {
    var headers = {
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com',
      'X-RapidAPI-Key': 'baf41e5371mshc97f4d28e95a407p112358jsnd26e90d153a1',
    };
    return apiService
        .getGetApiResponse(AppUrls.moviesListEndPoint, headers: headers)
        .then((value) =>  MoviesModel.fromJson(value));
  }
}

