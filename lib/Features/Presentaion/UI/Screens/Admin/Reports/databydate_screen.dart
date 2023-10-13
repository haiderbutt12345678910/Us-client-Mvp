import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/LocalEntities/vote_model_chracter.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataByDateScreen extends StatefulWidget {
  const DataByDateScreen({super.key});

  @override
  State<DataByDateScreen> createState() => _DataByDateScreenState();
}

class _DataByDateScreenState extends State<DataByDateScreen> {
  List<DailyVotesEntity> dailyvoteList = [];
  List<VoteModelChracter> byDateDataList = [];

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat =
      DateFormat('yy\\MM\\dd'); // Define the date format

  @override
  void initState() {
    dailyvoteList =
        BlocProvider.of<ReadVotesCubit>(context).readDailyVoteListLocall();
    filterList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width /
                2, // Set width to one-third of the screen
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  dateFormat.format(selectedDate),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                    width: 10), // Add some spacing between the text and icon
                IconButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        filterList();
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    size: 30,
                  ), // Calendar icon
                  color: Colors.blue, // Adjust the icon color
                ),
              ],
            ),
          ),
          if (byDateDataList.isEmpty)
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text(
                "No Data Found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
          if (byDateDataList.isNotEmpty)
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: dateFormat.format(selectedDate)),
                legend: const Legend(isVisible: false),
                series: <BarSeries<VoteModelChracter, String>>[
                  BarSeries<VoteModelChracter, String>(
                    dataSource: byDateDataList,
                    xValueMapper: (VoteModelChracter votes, _) =>
                        votes.characterEntity.name as String,
                    yValueMapper: (VoteModelChracter votes, _) {
                      return votes
                          .characterDailyVotesEntity.characterTotalDailyVotes;
                    },
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void filterList() {
    byDateDataList.clear();
    byDateDataList = [];
    final String dataForDate = dateFormat.format(selectedDate);

    // Find the list of daily votes for the selected date
    DailyVotesEntity localList = dailyvoteList.firstWhere(
        (element) => element.date == dataForDate,
        orElse: () => DailyVotesEntity());

    if (localList.charactersDailyVotesList == null) {
      return;
    }
    localList.charactersDailyVotesList?.forEach((element) {
      byDateDataList.add(VoteModelChracter(
          characterDailyVotesEntity: element,
          characterEntity: CharacterEntity(
              imageUrl: "", name: "", uid: element.characterId)));
    });

    var chracterList = BlocProvider.of<ReadCharactersCubit>(context)
        .readCharactersListLocall();

    byDateDataList.forEach((element) {
      for (int i = 0; i < chracterList.length; i++) {
        if (chracterList[i].uid == element.characterEntity.uid) {
          element.characterEntity.imageUrl = chracterList[i].imageUrl;
          element.characterEntity.name = chracterList[i].name;
          break;
        }
      }
    });
  }
}
