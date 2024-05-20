import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme/model/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // createUser(UserModel user) async {
  //   try {
  //     final userId = user.email.hashCode.toString();
  //     await _db.collection("Users").doc(userId).set(user.toJson());
  //     print("User data saved succesfully with userId: $userId");
  //   } catch (e) {
  //     print("Error saving user data: $e");
  //   }
  // }

  createUser(UserModel user) async {
    try {
      final userId = user.email.hashCode.toString();
      print("Saving user data with userId: $userId");
      print("User data: ${user.toJson()}");
      await _db.collection("Users").doc(userId).set(user.toJson());
      print("User data saved successfully with userId: $userId");
    } catch (e) {
      print("Error saving user data: $e");
      // Handle the error gracefully (e.g., show an error message to the user)
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final UserData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return UserData;
  }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs
        .map((e) =>
            UserModel.fromSnapshot(e.data() as DocumentSnapshot<Object?>))
        .toList();
    return userData;
  }

  Future<void> updateUserEmailAndAddress(String userId, String newEmail) async {
    try {
      await _db.collection("Users").doc(userId).update({
        'Email': newEmail,
      });
      print("User email and address updated succefully for : $userId");
    } catch (e) {
      print("Error updating user email and address:$e");
    }
  }
}
