import 'package:cosme/model/auth_controller.dart';
import 'package:cosme/model/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthController());
  final _userRepo = Get.put(UserRepository());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  getUserData() {
    final email = _authRepo.auth.currentUser?.email;
    print("update: email: $email");
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  void handleUpdateEmailAndAddress(String newEmail, String newAddress) async {
    final currentUser = await getUserData(); // Make sure to await the result

    if (currentUser != null) {
      try {
        await _userRepo.updateUserEmailAndAddress(
          currentUser.email,
          newEmail,
        );
        print(
            "Email and address updated successfully for ${currentUser.email}");
      } catch (e) {
        print("Error updating email and address: $e");
      }
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

// Rest of your controller code...
}
