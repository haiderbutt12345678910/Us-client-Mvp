import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class UpdateCharacterOrUserUseCase {
  final Repository repository;

  UpdateCharacterOrUserUseCase({required this.repository});

  Future<void> updateChracterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    return await repository.updateChracterOrUser(
        userEntity, characterEntity, image);
  }
}
