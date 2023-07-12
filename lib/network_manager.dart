import 'package:dio/dio.dart';
import 'model/cat.dart';

class NetworkManager {
  final Dio _dio = Dio();
  final _baseUrl = 'https://api.thecatapi.com/v1';
  final _apiKey =
      'live_cAEdQfaTenl7QbHxYMjQSn21iYve0mZWoiL3ToCQEn82fXjaASgZA09QgKI3IOCq';

  Future<Cat?> getRandomPic() async {
    Cat? cat;
    try {
      Response catData = await _dio.get(_baseUrl + '/images/search?api_key=' + _apiKey);
      print('Cat Info: ${catData.data}');
      cat = Cat.fromJson(catData.data[0]);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return cat;
  }
}
