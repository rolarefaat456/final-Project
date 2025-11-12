import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manager/home_controller.dart';

class CityData extends StatefulWidget {
  const CityData({super.key, required this.lon, required this.lat});

  final double lon, lat;

  @override
  State<CityData> createState() => _CityDataState();
}

class _CityDataState extends State<CityData> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    // جلب البيانات عند بدء الشاشة
    Future.microtask(() {
      homeController.getPlaceData(
        categoryType: 'tourism.attraction',
        lon: widget.lon,
        lat: widget.lat,
        radius: 5000,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (homeController.placeData.isEmpty) {
        return const Center(child: Text('No data found'));
      }

      return ListView.builder(
        itemCount: homeController.placeData.length,
        itemBuilder: (context, index) {
          final place = homeController.placeData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                // FutureBuilder لجلب صورة المكان من API
                FutureBuilder<String?>(
                  future: homeController.getPlaceImage(
                    language: 'ar',
                    placeName: place.name,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }

                    final imageUrl = snapshot.data;
                    if (imageUrl != null) {
                      return Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.place, color: Colors.blueAccent),
                      );
                    }

                    return const Icon(Icons.place, color: Colors.blueAccent);
                  },
                ),

                // تفاصيل المكان
                ListTile(
                  leading: place.imageUrl != null
                      ? Image.network(
                          place.imageUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.place, color: Colors.blueAccent),
                        )
                      : const Icon(Icons.place, color: Colors.blueAccent),
                  title: Text(
                    place.name.isNotEmpty ? place.name : "Unnamed place",
                  ),
                  subtitle: Text(place.formattedAddress),
                  trailing: Text(
                    place.categories.isNotEmpty
                        ? place.categories.first
                        : "No category",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
