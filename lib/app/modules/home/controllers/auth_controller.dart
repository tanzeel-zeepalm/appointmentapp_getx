import 'package:appoitment_app/app/Model/user_model.dart';
import 'package:appoitment_app/app/Services/database_services.dart';
import 'package:appoitment_app/app/modules/home/Widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _firebaseUser = Rx<User?>(null);
  User? get user => _firebaseUser.value;
  DatabaseServices db = DatabaseServices();

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    update();
    super.onInit();
  }

  Future<void> signup({required String email, required String password, required String name,
      required String image}) async {
     showLoadingDialog();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        UserModel myuser = UserModel(
          id: value.user!.uid,
          email: value.user!.email!,
          name: name,
            pic: image,
        );
        await _createUserFirestore(myuser, value.user!);
       dismissLoadingDialog();
      });
    } on FirebaseAuthException catch (e) {
      dismissLoadingDialog();
      Get.snackbar('User', 'Message', messageText: Text(e.toString()));
    }
    ;
  }

  Future<void> _createUserFirestore(UserModel user, User firebaseUser) async {
    await db.userCollection.doc(firebaseUser.uid).set(user.toMap());
    update();
  }

  Future login({required String email, required String password}) async {
     showLoadingDialog();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
       dismissLoadingDialog();
    } on FirebaseAuthException catch (e) {
       dismissLoadingDialog();
      Get.snackbar('User', 'Message', messageText: Text(e.toString()));
    }
  }
}
