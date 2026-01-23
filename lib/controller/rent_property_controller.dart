import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/property_card_model.dart';

class RentPropertyController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  RxList<Property> propertyList = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProperties();
  }

  void fetchProperties() {
    _firebaseService.fetchproperty().listen((data) {
      propertyList.assignAll(data);
    });
  }

  Future<void> refreshProperties() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate refresh time
    fetchProperties(); // re-listen to Firestore updates
  }
}
