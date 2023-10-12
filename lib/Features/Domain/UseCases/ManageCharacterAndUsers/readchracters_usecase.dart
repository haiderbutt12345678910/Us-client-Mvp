import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class ReadCharactersUseCase {
  final Repository repository;

  ReadCharactersUseCase({required this.repository});

  Future<List<CharacterEntity>> readCharacters() async {
    return await repository.readCharacters();
  }
}
