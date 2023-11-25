import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  void initState() {
    super.initState();
  }

  static const CameraPosition _bishkek = CameraPosition(
    target: LatLng(35.7517769362014, 37.61637210845947),
    zoom: 14,
  );

  static const CameraPosition _home = CameraPosition(
    target: LatLng(35.7517769362014, 37.61637210845987),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    const LatLng center = LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Container(
      padding: const EdgeInsets.only(top: 50),
      color: Colors.amber,
      child: Center(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.satellite,
          // markers: <Marker>{

          // },
          initialCameraPosition: const CameraPosition(
            target: center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
