import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyVoteDataScreen extends StatefulWidget {
  const DailyVoteDataScreen({super.key});

  @override
  State<DailyVoteDataScreen> createState() => _DailyVoteDataScreenState();
}

class _DailyVoteDataScreenState extends State<DailyVoteDataScreen> {
  List<DailyVotesEntity> dailyvoteList = [];

  @override
  void initState() {
    dailyvoteList =
        BlocProvider.of<ReadVotesCubit>(context).readDailyVoteListLocall();

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
                items: <String>[
                  'All Time',
                  'Last 7 Days',
                  'Last 30 days',
                ].map((String value) {
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
                      dailyvoteList = BlocProvider.of<ReadVotesCubit>(context)
                          .readDailyVoteListLocall();
                    } else if (selectedValue == 'Last 7 Days') {
                      if (dailyvoteList.length > 7) {
                        var list = BlocProvider.of<ReadVotesCubit>(context)
                            .readDailyVoteListLocall();
                        dailyvoteList.clear();
                        for (int i = 0; i < 7; i++) {
                          dailyvoteList.add(list[i]);
                        }
                      } else {
                        dailyvoteList = BlocProvider.of<ReadVotesCubit>(context)
                            .readDailyVoteListLocall();
                      }
                    } else {
                      if (dailyvoteList.length > 30) {
                        var list = BlocProvider.of<ReadVotesCubit>(context)
                            .readDailyVoteListLocall();
                        dailyvoteList.clear();
                        for (int i = 0; i < 30; i++) {
                          dailyvoteList.add(list[i]);
                        }
                      } else {
                        dailyvoteList = BlocProvider.of<ReadVotesCubit>(context)
                            .readDailyVoteListLocall();
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
                title: ChartTitle(text: selectedValue),
                legend: const Legend(isVisible: false),
                series: <BarSeries<DailyVotesEntity, String>>[
                  BarSeries<DailyVotesEntity, String>(
                    dataSource: dailyvoteList,
                    xValueMapper: (DailyVotesEntity votes, _) => votes.date,
                    yValueMapper: (DailyVotesEntity votes, _) {
                      return votes.totalVotes;
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
