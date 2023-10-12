import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/readvote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/Reports/charcatervotedata_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/Reports/dailyvotedata_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/Reports/popularirydata_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Widget> list = [
    const DailyVoteDataScreen(),
    const PopularityChartsScreen(),
    const CharacterVoteDataScreen()
    // Add more widgets for other tabs as needed
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(drawerId: "0"),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<ReadVotesCubit>(context).readDailyVoteList();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<ReadVotesCubit, BlocStates>(builder: (ctx, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (state is Failure)
              const Center(
                child: Text("Some Thing Went Wrong! Refresh Again"),
              ),
            if (state is Sucessfull) list[_selectedIndex],
            if (state is Loading) const CustomCircularBar()
          ],
        );
      }), // Show the content based on the selected index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Votes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Popularity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'By Character',
          ),
        ],
      ),
    );
  }
}
