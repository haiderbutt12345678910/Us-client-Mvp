import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/signIn_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<BlocStates> {
  SignInUseCase signInUseCase;

  SignInCubit({required this.signInUseCase}) : super(Initial());

  Future<void> logIn(String email, String password) async {
    emit(Loading());
    try {
      await signInUseCase.signIn(email, password).then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
