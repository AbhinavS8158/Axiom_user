import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/property_card_model.dart';


class SellPropertyController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  // Observable list of properties
  var propertyList = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenToProperties();
  }

  void _listenToProperties() {
    _firebaseService.fetchsellproperty().listen((properties) {
      propertyList.value = properties;
    });
  }
}
