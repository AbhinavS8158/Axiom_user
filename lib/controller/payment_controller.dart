import 'package:get/get.dart';

class PaymentController extends GetxController{
  RxString selectedMethod =''.obs;
  RxBool isProcessing = false.obs;


  void selectMethod(String method){
    selectedMethod .value =method;
  }

  void startProcessing(){
    isProcessing.value=true;
  }

  void stopProcessing(){
    isProcessing.value=false;
  }
}