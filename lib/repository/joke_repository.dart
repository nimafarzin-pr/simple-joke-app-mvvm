import '../data/network/network_api_services.dart';
import '../models/movies.dart';
import '../res/app_url.dart';

class JokeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<JokeModel> getJoke() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.jokeBaseUrl);
      return response = JokeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
