
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/home_provider.dart';

class CityData extends StatefulWidget {
  const CityData({
    super.key, required this.lon, required this.lat,
  });
  final double lon, lat;

  @override
  State<CityData> createState() => _CityDataState();
}

class _CityDataState extends State<CityData> {

    @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<HomeProvider>(context, listen: false).getPlaceData(
        categoryType: 'tourism.attraction',
        lon: widget.lon,
        // 31.2357,
        lat: widget.lat,
        //  30.0444,
        radius: 5000,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
    
        if (provider.placeData.isEmpty) {
          return const Center(child: Text('No data found '));
        }
    
        return ListView.builder(
          itemCount: provider.placeData.length,
          itemBuilder: (context, index) {
            final place = provider.placeData[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: Column(
                children: [
                  FutureBuilder<String?>(
                    future: provider.getPlaceImage(
                      language: 'ar',
                      placeName: place.name,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
    
                      final imageUrl = snapshot.data;
                      if (imageUrl != null) {
                        return Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.place,
                                    color: Colors.blueAccent,
                                  ),
                        );
                      }
    
                      return const Icon(
                        Icons.place,
                        color: Colors.blueAccent,
                      );
                    },
                  ),
    
                  ListTile(
                    leading: place.imageUrl != null
                        ? Image.network(
                            place.imageUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.place,
                                      color: Colors.blueAccent,
                                    ),
                          )
                        : const Icon(
                            Icons.place,
                            color: Colors.blueAccent,
                          ),
                    title: Text(
                      place.name.isNotEmpty
                          ? place.name
                          : "Unnamed place",
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
      },
    );
  }
}
