class Property {
  final String id;
  final String userId;
  final String title;
  final String location;
  final double latitude;
  final double longitude;
  final String price;
  final String type;
  final String bedrooms;
  final String bathrooms;
  final String email;
  final String status;
  final List<String> imageUrl;
  final String phone;
  final String about;
  final String user;
  final String propertyType;
  final String collectiontype;
  final String powerbackup;
  final String constructionstatus;
  final List<Map<String, dynamic>> amenities;
  final String food;

  Property({
    required this.id,
    required this.userId,
    required this.title,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.email,
    required this.status,
    required this.imageUrl,
    required this.phone,
    required this.about,
    required this.user,
    required this.propertyType,
    required this.collectiontype,
    required this.powerbackup,
    required this.amenities,
    required this.constructionstatus,
    required this.food,
  });

  /// ✅ Convert to JSON (for saving)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'amount': price,
      'propertyType': type,
      'bedroom': bedrooms,
      'bathroom': bathrooms,
      'email': email,
      'status': status,
      'photoPath': imageUrl,
      'phoneNumber': phone,
      'about': about,
      'user': user,
      'collectiontype': collectiontype,
      'powerbackup': powerbackup,
      'amenities': amenities,
      'constructionstatus': constructionstatus,
      'food': food,
    };
  }

  /// ✅ Factory to create from Firestore Map
  factory Property.fromMap(Map<String, dynamic> data, String documentId) {
    // Handle amenities safely (can be List<Map> or List<String>)
    List<Map<String, dynamic>> parsedAmenities = [];

    if (data['amenities'] is List) {
      var rawList = data['amenities'] as List;
      if (rawList.isNotEmpty) {
        if (rawList.first is Map) {
          parsedAmenities = List<Map<String, dynamic>>.from(rawList);
        } else if (rawList.first is String) {
          parsedAmenities =
              rawList.map((e) => {'name': e.toString()}).toList();
        }
      }
    }

    return Property(
      id: documentId,
      userId: data['uid']?? '',
      title: data['name'] ?? '',
      location: data['location'] ?? '',
      latitude: (data['latitude'] is num)
          ? (data['latitude'] as num).toDouble()
          : 0.0,
      longitude: (data['longitude'] is num)
          ? (data['longitude'] as num).toDouble()
          : 0.0,
      price: data['amount']?.toString() ?? '',
      type: data['propertyType'] ?? '',
      bedrooms: data['bedroom']?.toString() ?? '0',
      bathrooms: data['bathroom']?.toString() ?? '0',
      email: data['email'] ?? '',
      status: data['status']?.toString() ?? '',
      imageUrl: (data['photoPath'] != null && data['photoPath'] is List)
          ? List<String>.from(data['photoPath'])
          : [],
      phone: data['phoneNumber'] ?? '',
      about: data['about'] ?? '',
      user: data['user'] ?? '',
      propertyType: data['propertyType'] ?? '',
      collectiontype: data['collectiontype'] ?? '',
      powerbackup: data['powerbackup'] ?? '',
      amenities: parsedAmenities,
      constructionstatus: data['constructionstatus'] ?? '',
      food: data['food'] ?? '',
    );
  }
}
