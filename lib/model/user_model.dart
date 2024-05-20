import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String fullname;
  late final String email;
  final String phoneno;
  final String password;
  final String Confirmpassword;
  final String role;

  UserModel({
    required this.fullname,
    required this.email,
    required this.phoneno,
    required this.password,
    required this.Confirmpassword,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullname,
      "Email": email,
      "phone": phoneno,
      "password": password,
      "Confirmpassword": Confirmpassword,
      "role": role,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot ss) {
    final data = ss.data() as Map<String, dynamic>;
    return UserModel(
      fullname: data["FullName"] ?? "",
      email: data["Email"] ?? "",
      phoneno: data["phone"] ?? "",
      password: data["password"] ?? "",
      Confirmpassword: data["Confirmpassword"] ?? "",
      role: data["role"] ?? "",
    );
  }
}
