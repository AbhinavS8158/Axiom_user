import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:user/model/user_model.dart';

class ProfileController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Rx<AppUser?> user = Rx<AppUser?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToUser();
  }

  void _listenToUser() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      isLoading.value = false;
      return;
    }

    _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        user.value = AppUser.fromMap(doc.data()!, doc.id);
      }
      isLoading.value = false;
    });
  }
}
