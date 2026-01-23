import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildLocationCard(Property property) {
  Future<Map<String, double>?> getCoordinatesFromAddress(
      String address) async {
    try {
      List<Location> locations =
          await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final loc = locations.first;
        log("✅ Coordinates found: ${loc.latitude}, ${loc.longitude}");
        return {
          'latitude': loc.latitude,
          'longitude': loc.longitude,
        };
      } else {
        log("⚠️ No results found for $address");
        return null;
      }
    } catch (e) {
      log("❌ Error while converting address to coordinates: $e");
      return null;
    }
  }

  final String address = property.location;

  return FutureBuilder<Map<String, double>?>(
    future: getCoordinatesFromAddress(address),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.grey1,
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData || snapshot.data == null) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.grey1,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off,
                    color: AppColor.grey, size: 40),
                const SizedBox(height: 8),
                Text(
                  'Unable to load map for:',
                  style: TextStyle(color: AppColor.grey2),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.grey),
                ),
              ],
            ),
          ),
        );
      }

      final double lat = snapshot.data!['latitude']!;
      final double lng = snapshot.data!['longitude']!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.grey1,
            ),
            clipBehavior: Clip.hardEdge,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(lat, lng),
                initialZoom: 15.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom |
                      InteractiveFlag.drag |
                      InteractiveFlag.doubleTapZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.user',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(lat, lng),
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.location_pin,
                        color: AppColor.fav,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              address,
              style: TextStyle(
                color: AppColor.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
