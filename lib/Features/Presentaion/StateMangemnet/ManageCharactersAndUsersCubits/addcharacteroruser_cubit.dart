import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/addcharacteroruser_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCharaterOrUserCubit extends Cubit<BlocStates> {
  AddCharacterOrUserUseCase addCharacterOrUserUseCase;

  AddCharaterOrUserCubit({required this.addCharacterOrUserUseCase})
      : super(Initial());

  Future<void> addCharacterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    emit(Loading());
    try {
      await addCharacterOrUserUseCase
          .addCharacterOrUser(userEntity, characterEntity, image)
          .then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
