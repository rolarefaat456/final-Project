import 'package:dio/dio.dart';
import 'package:finalpro/core/constans/endpoints.dart';
import 'package:finalpro/core/network/api_error.dart';
import 'package:finalpro/core/network/api_exceptions.dart';
import 'package:finalpro/core/network/api_service.dart';
import 'package:finalpro/feature/home/data/home_model.dart';

class HomeRepo {
  ApiService apiService = ApiService();
  final Dio dio = Dio();

  HomeRepo();
  Future<List<PlaceModel>> getPlaceData({
    required String categoryType,
    required double lon,
    required double lat,
    required int radius,
  }) async {
    // categories may be ==>
    /// tourism
    /// accommodation
    /// eat_drink
    /// shop
    /// transportation
    /// leisure
    /// health
    /// education
    /// entertainment
    /// religion
    /// financial
    /// office
    try {
      final response = await apiService.get(
        endPoint:
            '$places?$categories=$categoryType&filter=circle:$lon,$lat,$radius&limit=20&apiKey=$key',
      );
      print(response);
      if (response.isNotEmpty) {
        final features = response['features'] as List? ?? [];
        return features.map((e) => PlaceModel.fromJson(e)).toList();
      }
      return [];
    } on ApiExceptions catch (e) {
      throw ApiError(message: e.toString());
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<String?> fetchImage({ required String language, required areaName}) async {
    final url = 'https://$language.wikipedia.org/api/rest_v1/page/summary/$areaName';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['thumbnail'] != null && data['thumbnail'].isNotEmpty) {
          return data['thumbnail']['source'];
        }
      } else {}
    } catch (e) {
      throw ApiError(message: e.toString());
    }

    return null;
  }
}
