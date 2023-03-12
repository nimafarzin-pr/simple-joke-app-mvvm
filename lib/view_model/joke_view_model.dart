import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../models/movies.dart';
import '../repository/joke_repository.dart';

class JokeViewModel extends ChangeNotifier {
  final _popularMovieRepo = JokeRepository();
  ApiResponse<JokeModel> joke = ApiResponse.loading();
  JokeViewModel() {
    fetchJoke();
  }
  setMoviesList(ApiResponse<JokeModel> response) {
    joke = response;
    notifyListeners();
  }

  makeLoading() {
    joke = ApiResponse.loading();
    notifyListeners();
  }

  Future<void> fetchJoke() async {
    makeLoading();
    await _popularMovieRepo.getJoke().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
