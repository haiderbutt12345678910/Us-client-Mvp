import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/updatechracteroruser_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCharacterOrUserCubit extends Cubit<BlocStates> {
  UpdateCharacterOrUserUseCase updateCharacterOrUserCubit;

  UpdateCharacterOrUserCubit({required this.updateCharacterOrUserCubit})
      : super(Initial());

  Future<void> updateChracterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    emit(Loading());
    try {
      await updateCharacterOrUserCubit
          .updateChracterOrUser(userEntity, characterEntity, image)
          .then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
