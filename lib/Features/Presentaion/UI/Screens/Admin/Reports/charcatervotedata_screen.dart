import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/LocalEntities/vote_model_chracter.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChracterVoteDataScreen extends StatefulWidget {
  const ChracterVoteDataScreen({super.key});

  @override
  State<ChracterVoteDataScreen> createState() => _ChracterVoteDataScreenState();
}

class _ChracterVoteDataScreenState extends State<ChracterVoteDataScreen> {
  List<CharacterEntity> selectedChratcers = [];
  List<DailyVotesEntity> dailyvoteList = [];
  List<CharacterEntity> chracterEntityList = [];
  List<List<VoteModelChracter>> voteModelChratcerdataList = [[]];
  String selectedChracterTitle = "";
  String selectedId = "";

  late DateTime fromDate;
  late DateTime toDate;
  final dateFormat = DateFormat('yy\\MM\\dd');

  List<MultiSelectItem<CharacterEntity>> multiSelectList = [];

  @override
  void initState() {
    chracterEntityList = BlocProvider.of<ReadCharactersCubit>(context)
        .readCharactersListLocall();

    selectedChratcers.add(chracterEntityList[0]);

    for (int i = 0; i < chracterEntityList.length; i++) {
      multiSelectList.add(MultiSelectItem<CharacterEntity>(
          chracterEntityList[i], chracterEntityList[i].name as String));
    }
    selectedChracterTitle = chracterEntityList[0].name as String;
    selectedId = chracterEntityList[0].uid as String;

    dailyvoteList =
        BlocProvider.of<ReadVotesCubit>(context).readDailyVoteListLocall();

    fromDate = dateFormat
        .parse(dailyvoteList[dailyvoteList.length - 1].date as String);
    toDate = dateFormat.parse(dailyvoteList[0].date as String);

    filterList();

    super.initState();
  }

  var selectedValue = "All Time";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'From  ${fromDate != null ? dateFormat.format(fromDate) : "Select"}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: fromDate,
                                  firstDate: DateTime(2023),
                                  lastDate: toDate,
                                );
                                if (picked != null && picked != fromDate) {
                                  setState(() {
                                    fromDate = picked;
                                    filterList();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'To  ${toDate != null ? dateFormat.format(toDate) : "Select"}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: toDate,
                                  firstDate: fromDate,
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null && picked != toDate) {
                                  setState(() {
                                    if (picked.isAfter(fromDate)) {
                                      toDate = picked;
                                    } else {
                                      fromDate = picked;
                                    }
                                    filterList();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: MultiSelectDialogField(
                      initialValue: selectedChratcers,
                      items: multiSelectList,
                      title: const Text("Characters"),
                      selectedColor: Colors.black,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      buttonText: const Text(
                        "Select Characters",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        selectedChratcers = results.toList();
                        setState(() {
                          filterList();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedChratcers.length,
                      itemBuilder: ((context, index) {
                        return SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(
                              text: (selectedChratcers[index].name as String)),
                          legend: const Legend(isVisible: false),
                          series: <BarSeries<VoteModelChracter, String>>[
                            BarSeries<VoteModelChracter, String>(
                              dataSource: voteModelChratcerdataList[index],
                              xValueMapper: (VoteModelChracter votes, _) =>
                                  votes.date as String,
                              yValueMapper: (VoteModelChracter votes, _) {
                                return votes.characterDailyVotesEntity
                                    .characterTotalDailyVotes;
                              },
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              color: Colors.green,
                            ),
                          ],
                        );
                      }))),
            ],
          ),
        ),
      ),
    );
  }

  void filterList() {
    print(selectedChratcers.length);

    voteModelChratcerdataList.clear();

    List<DailyVotesEntity> filteredList = dailyvoteList.where((element) {
      DateTime elementDate = dateFormat.parse(element.date as String);
      return (elementDate.isAtSameMomentAs(fromDate) ||
              elementDate.isAfter(fromDate)) &&
          (elementDate.isAtSameMomentAs(toDate) ||
              elementDate.isBefore(toDate));
    }).toList();

    for (int k = 0; k < selectedChratcers.length; k++) {
      // Create an inner list if it doesn't exist yet
      if (voteModelChratcerdataList.length <= k) {
        voteModelChratcerdataList.add([]);
      }

      filteredList.forEach((daily) {
        for (int i = 0; i < daily.charactersDailyVotesList!.length; i++) {
          if (daily.charactersDailyVotesList![i].characterId ==
              selectedChratcers[k].uid) {
            voteModelChratcerdataList[k].add(VoteModelChracter(
              characterDailyVotesEntity: daily.charactersDailyVotesList![i],
              characterEntity: chracterEntityList.firstWhere(
                  (element) => element.uid == selectedChratcers[k].uid),
              date: daily.date,
            ));
          }
        }
      });
    }

    print(voteModelChratcerdataList.length);
  }
}
