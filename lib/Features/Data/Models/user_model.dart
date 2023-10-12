import '../../Domain/Entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? uid,
    String? userName,
    String? password,
  }) : super(password: password, uid: uid, userName: userName);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'password': password,
    };
  }
}
