import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/signout_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutCubit extends Cubit<BlocStates> {
  SignOutUseCase signOutUseCase;

  SignOutCubit({required this.signOutUseCase}) : super(Initial());

  Future<void> signOut() async {
    emit(Loading());
    try {
      await signOutUseCase.signOut().then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
