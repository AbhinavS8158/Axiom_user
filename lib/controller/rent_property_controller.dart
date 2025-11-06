import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/property_card_model.dart';


class RentPropertyController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  // Observable list of properties
  var propertyList = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenToProperties();
  }

  void _listenToProperties() {
    _firebaseService.fetchproperty().listen((properties) {
      propertyList.value = properties;
      
    });
   
  }
}
