class FilterModel {
  String propertyType;
  String priceRange;
  String bedrooms;
 

  FilterModel({
    this.propertyType = '',
    this.priceRange = '',
    this.bedrooms = '',
    
  });

  void clear() {
    propertyType = '';
    priceRange = '';
    bedrooms = '';
   
  }

  @override
  String toString() {
    return 'FilterModel(propertyType: $propertyType, priceRange: $priceRange, bedrooms: $bedrooms)';
  }
}
