import 'package:http/http.dart' as http;
import 'package:task/data/model/move_trend_model.dart';
import 'package:task/data/model/popular.dart';
import 'dart:convert';

import 'package:task/data/model/result_model.dart';

class ApiCall{


  Future<MovieTrends?> getTrendData() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=7e718bbe884ff492360be457092aa3fb');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('k ${MovieTrends.fromJson(jsonDecode(response.body))}');
      return MovieTrends.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    var responseBody = jsonDecode(response.body);
    print(responseBody);

  }


  Future<PopularMovies?> getPopularData() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=7e718bbe884ff492360be457092aa3fb&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('k ${PopularMovies.fromJson(jsonDecode(response.body))}');
      return PopularMovies.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    var responseBody = jsonDecode(response.body);
    print(responseBody);
  }



  Future<ResultModel?> getPopularDetailesData() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=7e718bbe884ff492360be457092aa3fb&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    var responseBody = jsonDecode(response.body);
    print(responseBody);
  }

}
