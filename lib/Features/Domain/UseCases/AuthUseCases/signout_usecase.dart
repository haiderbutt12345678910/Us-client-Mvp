import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class SignOutUseCase {
  final Repository repository;

  SignOutUseCase({required this.repository});

  Future<void> signOut() async {
    return await repository.signOut();
  }
}
