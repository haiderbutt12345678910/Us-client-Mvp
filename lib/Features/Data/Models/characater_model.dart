import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    String? imageUrl,
    String? uid,
    String? name,
  }) : super(imageUrl: imageUrl, uid: uid, name: name);

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      uid: json['uid'],
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'name': name,
    };
  }
}
