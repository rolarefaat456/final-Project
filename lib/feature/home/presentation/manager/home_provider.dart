import 'package:flutter/material.dart';

import '../../data/home_model.dart';
import '../../data/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo = HomeRepo();

  bool isLoading = false;
  List<PlaceModel> placeData = [];

  Future<void> getPlaceData({
    required String categoryType,
    required double lon,
    required double lat,
    required int radius,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await homeRepo.getPlaceData(
        categoryType: categoryType,
        lon: lon,
        lat: lat,
        radius: radius,
      );
      placeData = data;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<String?> getPlaceImage({required String language, required String placeName}) async {
    return await homeRepo.fetchImage( language: language, areaName: placeName);
  }
}
