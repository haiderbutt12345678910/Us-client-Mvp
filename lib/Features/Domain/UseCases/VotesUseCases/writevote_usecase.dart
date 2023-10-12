import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class WriteDailyVoteUseCase {
  final Repository repository;

  WriteDailyVoteUseCase({required this.repository});

  Future<void> writeVote(String chracterId) async {
    return await repository.writeVote(chracterId);
  }
}
