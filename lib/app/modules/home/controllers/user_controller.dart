import 'package:appoitment_app/app/Model/user_model.dart';
import 'package:appoitment_app/app/Services/database_services.dart';
import 'package:appoitment_app/app/modules/home/Widgets/dialog.dart';
import 'package:appoitment_app/app/modules/home/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  DatabaseServices db = DatabaseServices();
  Rx<UserModel?> _userModel = UserModel(id: "").obs;
  AuthController authController = Get.find<AuthController>();

  UserModel get user => _userModel.value!;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> getCurrentUser() async {
    return await db.userCollection
        .doc(authController.user!.uid)
        .get()
        .then((doc) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    });
  }

  @override
  Future<void> onReady() async {
    _userModel.value = await getCurrentUser();

    super.onReady();
  }
  Future<void> updateUserEmail(
      {required String newEmail, required String name}) async {
    showLoadingDialog();
    try {
      await _auth.currentUser!.updateEmail(newEmail).then((result) async {
        db.userCollection
            .doc(_auth.currentUser!.uid)
            .update({'email': newEmail, 'name': name});
        dismissLoadingDialog();
      });
    } on FirebaseException catch (error) {
      dismissLoadingDialog();
      Get.snackbar('Update Failed', error.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
