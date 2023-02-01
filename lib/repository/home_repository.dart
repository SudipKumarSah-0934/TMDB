import 'package:tmdb_app/data/network/BaseApiServices.dart';
import 'package:tmdb_app/data/network/NetworkApiService.dart';
import 'package:tmdb_app/res/app_urls.dart';

import '../models/MoviesListModel.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<MoviesListModel> fetchListApi() async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.listUrl);
      return response = MoviesListModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}
