import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/LocalEntities/vote_model_chracter.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChracterVoteDataScreen extends StatefulWidget {
  const ChracterVoteDataScreen({super.key});

  @override
  State<ChracterVoteDataScreen> createState() => _ChracterVoteDataScreenState();
}

class _ChracterVoteDataScreenState extends State<ChracterVoteDataScreen> {
  List<DailyVotesEntity> dailyvoteList = [];
  List<CharacterEntity> chracterEntityList = [];
  List<VoteModelChracter> voteModelChratcerdataList = [];
  String selectedChracterTitle = "";
  String selectedId = "";

  @override
  void initState() {
    chracterEntityList = BlocProvider.of<ReadCharactersCubit>(context)
        .readCharactersListLocall();

    selectedChracterTitle = chracterEntityList[0].name as String;
    selectedId = chracterEntityList[0].uid as String;

    dailyvoteList =
        BlocProvider.of<ReadVotesCubit>(context).readDailyVoteListLocall();

    filterList();

    super.initState();
  }

  var selectedValue = "All Time";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
                width: size.width,
                height: size.width / 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chracterEntityList.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          selectedId = chracterEntityList[index].uid as String;
                          setState(() {
                            selectedChracterTitle =
                                chracterEntityList[index].name as String;
                            filterList();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * .04),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                chracterEntityList[index].imageUrl as String),
                          ),
                        ),
                      );
                    })),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: selectedChracterTitle),
                legend: const Legend(isVisible: false),
                series: <BarSeries<VoteModelChracter, String>>[
                  BarSeries<VoteModelChracter, String>(
                    dataSource: voteModelChratcerdataList,
                    xValueMapper: (VoteModelChracter votes, _) => votes.date,
                    yValueMapper: (VoteModelChracter votes, _) {
                      return votes
                          .characterDailyVotesEntity.characterTotalDailyVotes;
                    },
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Colors.greenAccent, // Bar color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterList() {
    voteModelChratcerdataList.clear();

    dailyvoteList.forEach((daily) {
      for (int i = 0; i < daily.charactersDailyVotesList!.length; i++) {
        if (daily.charactersDailyVotesList![i].characterId == selectedId) {
          voteModelChratcerdataList.add(VoteModelChracter(
              characterDailyVotesEntity: daily.charactersDailyVotesList![i],
              characterEntity: chracterEntityList
                  .firstWhere((element) => element.uid == selectedId),
              date: daily.date));
        }
      }
    });
  }
}
