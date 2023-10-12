import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/writevote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteVotesCubit extends Cubit<BlocStates> {
  WriteDailyVoteUseCase writeDailyVoteUseCase;

  WriteVotesCubit({required this.writeDailyVoteUseCase}) : super(Initial());

  Future<void> writeVote(String chracterId) async {
    emit(Loading());
    try {
      await writeDailyVoteUseCase.writeVote(chracterId).then((value) {
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }
}
