import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/response/api_response.dart';

import '../../models/MoviesListModel.dart';
import '../home_repository.dart';

class HomeViewModel with ChangeNotifier{
  final _myRepo = HomeRepository();
  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();
  setMoviesList(ApiResponse<MoviesListModel> response){
    moviesList=response;
    notifyListeners();
  }
  Future<void>fetchMoviesListApi()async{
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchListApi().then((value){
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}