// import 'package:finalpro/feature/home/data/home_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show
        GoogleMapController,
        Marker,
        MarkerId,
        LatLng,
        InfoWindow,
        CameraPosition,
        GoogleMap,
        CameraUpdate;
import 'widgets/city_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Maps',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CityMapScreen(
                // places: places
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CityMapScreen extends StatefulWidget {
  // final List<PlaceModel> places; // قائمة الأماكن

  const CityMapScreen({
    // required this.places,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CityMapScreenState createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.0444, 31.2357), // نقطة افتراضية (القاهرة مثلا)
        zoom: 5,
      ),
      markers: _markers,
      onMapCreated: (controller) {
        mapController = controller;
      },
    );
  }

  void addMarker(double lat, double lon, String title) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: LatLng(lat, lon),
      infoWindow: InfoWindow(title: title),
      onTap: () {
        _showCityData(lat, lon, title);
      },
    );

    setState(() {
      _markers.add(marker);
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lon), 12),
      );
    });
  }

  void _showCityData(double lat, double lon, String name) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        child: CityData(lat: lat, lon: lon),
      ),
    );
  }
}
