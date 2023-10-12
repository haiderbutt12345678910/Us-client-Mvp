import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class AddCharacterOrUserUseCase {
  final Repository repository;

  AddCharacterOrUserUseCase({required this.repository});

  Future<void> addCharacterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    return await repository.addCharacterOrUser(
        userEntity, characterEntity, image);
  }
}
