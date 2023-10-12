import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/readusers_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadUsersCubit extends Cubit<BlocStates> {
  ReadUsersUseCase readUsersUseCase;
  List<UserEntity> usersListLocall = [];

  ReadUsersCubit({required this.readUsersUseCase}) : super(Initial());

  Future<void> readUsers() async {
    emit(Loading());
    try {
      await readUsersUseCase.readUsers().then((value) {
        usersListLocall = value;
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }

  List<UserEntity> readUsersListLocall() {
    return usersListLocall;
  }
}
