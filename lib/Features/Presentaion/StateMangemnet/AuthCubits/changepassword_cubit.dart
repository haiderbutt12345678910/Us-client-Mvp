import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/changepassword_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<BlocStates> {
  ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase}) : super(Initial());

  Future<void> changePassword(String newPassword) async {
    emit(Loading());
    try {
      await changePasswordUseCase.changePassword(newPassword).then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
