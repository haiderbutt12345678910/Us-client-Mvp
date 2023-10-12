import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CharacterVoteDataScreen extends StatefulWidget {
  const CharacterVoteDataScreen({super.key});

  @override
  State<CharacterVoteDataScreen> createState() =>
      _CharacterVoteDataScreenState();
}

class _CharacterVoteDataScreenState extends State<CharacterVoteDataScreen> {
  List<VoteModelChracter> chraterDataList = [];
  List<VoteModelChracter> topFive = [];
  String text = "Top 5 All Time";

  @override
  void initState() {
    List<DailyVotesEntity> list =
        BlocProvider.of<ReadVotesCubit>(context).readDailyVoteListLocall();
    var readChracters = BlocProvider.of<ReadCharactersCubit>(context)
        .readCharactersListLocall();
    readChracters.forEach((chraters) {
      chraterDataList.add(VoteModelChracter(
          characterEntity: chraters,
          characterDailyVotesEntity: CharacterDailyVotesEntity(
              afternoonVotes: 0,
              characterId: chraters.uid,
              morningVotes: 0,
              characterTotalDailyVotes: 0,
              nightVotes: 0)));
    });

    chraterDataList.forEach((voteModelChracter) {
      list.forEach((dailyVotesEntity) {
        dailyVotesEntity.charactersDailyVotesList!.forEach((element) {
          if (element.characterId == voteModelChracter.characterEntity.uid) {
            voteModelChracter.characterDailyVotesEntity.afternoonVotes =
                (voteModelChracter.characterDailyVotesEntity.afternoonVotes ??
                        0) +
                    (element.afternoonVotes ?? 0);

            voteModelChracter.characterDailyVotesEntity.nightVotes =
                (voteModelChracter.characterDailyVotesEntity.nightVotes ?? 0) +
                    (element.nightVotes ?? 0);

            voteModelChracter.characterDailyVotesEntity.morningVotes =
                (voteModelChracter.characterDailyVotesEntity.morningVotes ??
                        0) +
                    (element.morningVotes ?? 0);

            voteModelChracter.characterDailyVotesEntity
                .characterTotalDailyVotes = (voteModelChracter
                        .characterDailyVotesEntity.characterTotalDailyVotes ??
                    0) +
                (element.characterTotalDailyVotes ?? 0);
          }
        });
      });
    });

    chraterDataList.sort((a, b) {
      final aVotes = a.characterDailyVotesEntity.characterTotalDailyVotes ?? 0;
      final bVotes = b.characterDailyVotesEntity.characterTotalDailyVotes ?? 0;
      return bVotes - aVotes;
    });

    for (int i = 0; i < 5; i++) {
      topFive.add(chraterDataList[i]);
    }
    super.initState();
  }

  var selectedValue = "All Time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                items: <String>['All Time', 'Morning', 'AfterNoon', 'Night']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue ?? 'All Time';
                    if (selectedValue == 'All Time') {
                      chraterDataList.sort((a, b) {
                        final aVotes = a.characterDailyVotesEntity
                                .characterTotalDailyVotes ??
                            0;
                        final bVotes = b.characterDailyVotesEntity
                                .characterTotalDailyVotes ??
                            0;
                        return bVotes - aVotes;
                      });

                      for (int i = 0; i < 5; i++) {
                        topFive.add(chraterDataList[i]);
                      }
                    } else if (selectedValue == 'Morning') {
                      chraterDataList.sort((a, b) {
                        final aVotes =
                            a.characterDailyVotesEntity.morningVotes ?? 0;
                        final bVotes =
                            b.characterDailyVotesEntity.morningVotes ?? 0;
                        return bVotes - aVotes;
                      });

                      for (int i = 0; i < 5; i++) {
                        topFive.add(chraterDataList[i]);
                      }
                    } else if (selectedValue == 'AfterNoon') {
                      chraterDataList.sort((a, b) {
                        final aVotes =
                            a.characterDailyVotesEntity.afternoonVotes ?? 0;
                        final bVotes =
                            b.characterDailyVotesEntity.afternoonVotes ?? 0;
                        return bVotes - aVotes;
                      });

                      for (int i = 0; i < 5; i++) {
                        topFive.add(chraterDataList[i]);
                      }
                    } else {
                      chraterDataList.sort((a, b) {
                        final aVotes =
                            a.characterDailyVotesEntity.nightVotes ?? 0;
                        final bVotes =
                            b.characterDailyVotesEntity.nightVotes ?? 0;
                        return bVotes - aVotes;
                      });

                      for (int i = 0; i < 5; i++) {
                        topFive.add(chraterDataList[i]);
                      }
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Top 5 $selectedValue'),
                legend: const Legend(isVisible: false),
                series: <BarSeries<VoteModelChracter, String>>[
                  BarSeries<VoteModelChracter, String>(
                    dataSource: topFive,
                    xValueMapper: (VoteModelChracter votes, _) =>
                        votes.characterEntity.name,
                    yValueMapper: (VoteModelChracter votes, _) {
                      if (selectedValue == "All Time") {
                        return votes
                            .characterDailyVotesEntity.characterTotalDailyVotes;
                      } else if (selectedValue == "AfterNoon") {
                        return votes.characterDailyVotesEntity.afternoonVotes;
                      } else if (selectedValue == "Morning") {
                        return votes.characterDailyVotesEntity.morningVotes;
                      } else {
                        return votes.characterDailyVotesEntity.nightVotes;
                      }
                    },
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Colors.redAccent, // Bar color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoteModelChracter {
  CharacterDailyVotesEntity characterDailyVotesEntity;
  CharacterEntity characterEntity;
  VoteModelChracter(
      {required this.characterDailyVotesEntity, required this.characterEntity});
}
