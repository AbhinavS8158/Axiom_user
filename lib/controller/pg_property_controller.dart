import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/property_card_model.dart';

class PgPropertyController extends GetxController{
  final FirebaseService _firebaseService =FirebaseService();

  RxList<Property> propertyList=<Property>[].obs;
  @override
  void onInit(){
    super.onInit();
    _listenToPgProperties();
  }
  void _listenToPgProperties(){
    _firebaseService .fetchpgproperty().listen((properties){
      propertyList.value=properties;
    });
  }
  Future<void>refreshPgProperties()async{
    await Future.delayed(const Duration(seconds: 1));
    _listenToPgProperties();
  }
  
}