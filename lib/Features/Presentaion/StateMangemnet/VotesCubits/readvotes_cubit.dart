import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/readvote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadVotesCubit extends Cubit<BlocStates> {
  ReadVoteUseCase readVoteUseCase;
  List<DailyVotesEntity> dailyVotesListLocall = [];

  ReadVotesCubit({required this.readVoteUseCase}) : super(Initial());

  Future<void> readDailyVoteList() async {
    emit(Loading());
    try {
      await readVoteUseCase.readDailyVoteList().then((value) {
        dailyVotesListLocall = value;
        emit(Sucessfull());
      });
    } on Exception catch (_) {
      emit(Failure());
    }
  }

  List<DailyVotesEntity> readDailyVoteListLocall() {
    return dailyVotesListLocall;
  }
}
