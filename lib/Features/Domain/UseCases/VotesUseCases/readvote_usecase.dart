import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class ReadVoteUseCase {
  final Repository repository;

  ReadVoteUseCase({required this.repository});

  Future<List<DailyVotesEntity>> readDailyVoteList() async {
    return await repository.readDailyVoteList();
  }
}
