import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/initailaScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToNextScreen(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Asset/Images/bg.png"), fit: BoxFit.cover)),
        ),
      ),
    );
  }

  void navigateToNextScreen(BuildContext context) {
    BlocProvider.of<ReadVotesCubit>(context).readDailyVoteList().then((value) {
      BlocProvider.of<ReadCharactersCubit>(context)
          .readCharacters()
          .then((value) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const InitialScreen()));
        });
      });
    });
  }
}
