import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/readchracters_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadCharactersCubit extends Cubit<BlocStates> {
  ReadCharactersUseCase readCharactersUseCase;
  List<CharacterEntity> charactersLocallList = [];

  ReadCharactersCubit({required this.readCharactersUseCase}) : super(Initial());

  Future<void> readCharacters() async {
    emit(Loading());
    try {
      await readCharactersUseCase.readCharacters().then((value) {
        charactersLocallList = value;
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }

  List<CharacterEntity> readCharactersListLocall() {
    return charactersLocallList;
  }
}
