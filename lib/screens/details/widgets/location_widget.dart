

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildLocationCard(Property property) {
  // final Property property;
  // ✅ Inner helper function to get coordinates from address
  Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    try {
      // 🔹 Get a list of possible matches for this address
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final loc = locations.first;
        print("✅ Coordinates found: ${loc.latitude}, ${loc.longitude}");
        return {
          'latitude': loc.latitude,
          'longitude': loc.longitude,
        };
      } else {
        print("⚠️ No results found for $address");
        return null;
      }
    } catch (e) {
      print("❌ Error while converting address to coordinates: $e");
      return null;
    }
  }

  final String address = property.location;

  return FutureBuilder<Map<String, double>?>(
    future: getCoordinatesFromAddress(address),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 🕒 Show loading spinner while geocoding
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
        // ⚠️ Show fallback if geocoding fails
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
                 Icon(Icons.location_off, color: AppColor.grey, size: 40),
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

      // ✅ Coordinates found, show map
      final double lat = snapshot.data!['latitude']!;
      final double lng = snapshot.data!['longitude']!;

      return Container(
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
            // 🗺️ Base map
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.user',
            ),

            // 📍 Marker for property location
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, lng),
                  width: 60,
                  height: 60,
                  child:  Icon(
                    Icons.location_pin,
                    color: AppColor.fav,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

