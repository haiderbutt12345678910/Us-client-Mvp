import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class SignInUseCase {
  final Repository repository;

  SignInUseCase({required this.repository});

  Future<void> signIn(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
