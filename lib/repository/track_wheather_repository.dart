import 'package:dio/dio.dart';
import 'package:moodwheatherweb/model/tracker_wheather_model.dart';

import '../config.dart';

class TrackerWheatherRepository {
  Future<TrackerWheather> listByCity(String city) async {
    try {
      var dio = Dio();
      final Map<String, String> mapHeaders = {
        'Access-Control-Allow-Methods': '*',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*'
      };
      dio.options.headers = mapHeaders;
      Response response = await dio.get("${Config.SERVER}/api/track/$city");
      print(response);
      return TrackerWheather.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      throw Future.error(e);
    }
  }
}
