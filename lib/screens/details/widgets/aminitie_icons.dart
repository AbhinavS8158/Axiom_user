import 'package:flutter/material.dart';

class AmenityIcons {
  static final Map<String, IconData> amenityMap = {
    "Car Parking": Icons.local_parking,
    "Childrens Playarea": Icons.child_care,
    "24x7 Water": Icons.water_drop,
    "Pool": Icons.pool,
    "24x7 Security": Icons.security,
    "Gym": Icons.fitness_center,
    "Lift": Icons.elevator,
    "Garden": Icons.park,
    "Fire Safety": Icons.fire_extinguisher,
    'Gas': Icons.local_gas_station,
    'Gate': Icons.door_sliding_outlined,
    'Pets Allowed':Icons.pets,
    'Fridge':Icons.kitchen,
    'Washing Machine': Icons.local_laundry_service,
  };

  static IconData getIcon(String amenityName) {
    return amenityMap[amenityName] ?? Icons.check_circle;
  }
}
