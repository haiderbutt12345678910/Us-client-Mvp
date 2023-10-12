import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class ChangePasswordUseCase {
  final Repository repository;

  ChangePasswordUseCase({required this.repository});

  Future<void> changePassword(String newPassword) async {
    return await repository.changePassword(newPassword);
  }
}
