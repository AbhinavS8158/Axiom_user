class FilterModel {
  String propertyType;
  String priceRange;
  String bedrooms;
  String services;
 

  FilterModel({
    this.propertyType = '',
    this.priceRange = '',
    this.bedrooms = '',
    this.services ='',
    
  });

   Map<String, dynamic> toJson() {
    return {
      'services': services,
      'propertyType': propertyType,
      'priceRange': priceRange,
      'bedrooms': bedrooms,
    };
  }

  /// ✅ Create FilterModel from map
  factory FilterModel.fromMap(Map<String, dynamic> data, String documentId) {
    return FilterModel(
      services: data['services'] ?? '',
      propertyType: data['propertyType'] ?? '',
      priceRange: data['priceRange'] ?? '',
      bedrooms: data['bedrooms'] ?? '',
    );
  }

  void clear() {
    propertyType = '';
    priceRange = '';
    bedrooms = '';
    services ='';
   
  }

  @override
  String toString() {
    return 'FilterModel(propertyType: $propertyType, priceRange: $priceRange, bedrooms: $bedrooms,services :$services)';
  }
}
