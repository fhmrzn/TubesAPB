import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pangyangjourney/features/feature/screens/nearby/widgets/maps_popup.dart';
import 'package:pangyangjourney/features/feature/screens/nearby/widgets/search_header.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/container/primary_header.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  _NearbyScreenState createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeader(
              child: Column(
                children: [
                  TAppBar(
                    title: Column(
                      children: [
                        Text(
                          TTexts.nearbyAppBarTitle,
                          style: Theme.of(context).textTheme.headlineSmall?.apply(color: TColors.black),
                        ),
                      ],
                    ),
                  ),
                  TSearchHeader(),
                ],
              ),
            ),
            if (_currentLocation != null)
              SizedBox(
                width: double.infinity,
                height: 800,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentLocation!,
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
                          width: 80,
                          height: 80,
                          child: const Icon(Iconsax.location, color: Colors.red, fill: 1),
                        ),
                        Marker(
                          point: LatLng(-6.8832123,107.5792426),
                          width: 80,
                          height: 80,
                          child: GestureDetector(
                            onTap: () => MarkerPopup(context),
                            child: const Icon(Iconsax.location, color: Colors.red, fill: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (_currentLocation == null)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
