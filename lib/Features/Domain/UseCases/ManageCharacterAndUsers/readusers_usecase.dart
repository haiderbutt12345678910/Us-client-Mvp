import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class ReadUsersUseCase {
  final Repository repository;

  ReadUsersUseCase({required this.repository});

  Future<List<UserEntity>> readUsers() async {
    return await repository.readUsers();
  }
}
