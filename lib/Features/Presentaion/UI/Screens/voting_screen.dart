import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/writevote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/writevotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var chracterList = [];
  @override
  void initState() {
    super.initState();
  }

  bool showThanakyouMassege = false;

  String chracterId = "";
  @override
  Widget build(BuildContext context) {
    var list = BlocProvider.of<ReadCharactersCubit>(context)
        .readCharactersListLocall();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<WriteVotesCubit, BlocStates>(builder: (ctx, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              if (showThanakyouMassege) thankYouCard(),
              if (!showThanakyouMassege)
                AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        delay: const Duration(milliseconds: 1000),
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: size.width * .01,
                                  right: size.width * .01,
                                  top: size.width * .2,
                                  bottom: size.width * .1),
                              width: size.width * .9,
                              height: size.height * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: InkWell(
                                  onTap: () {
                                    chracterId = list[index].uid as String;
                                    submit();
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Image.network(
                                      list[index].imageUrl
                                          as String, // Replace with your image source
                                      fit: BoxFit
                                          .cover, // Fit the image inside the card
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (!showThanakyouMassege)
                if (state is Loading) const CustomCircularBar()
            ],
          );
        }, listener: (ctx, state) {
          if (state is Sucessfull) {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Vote Regiterd Succesfully"),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              showThanakyouMassege = true;
            });
            startTimer();
          }

          if (state is Failure) {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 2),
              content: Text("Some Error Occured! Try Again"),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }));
  }

  void submit() {
    BlocProvider.of<WriteVotesCubit>(context).writeVote(chracterId);
  }

  Widget thankYouCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      height: double.infinity,
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_box_rounded,
            color: Colors.greenAccent,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Thank You!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void startTimer() {
    const duration = Duration(seconds: 3); // 3 seconds delay

    Future.delayed(duration, () {
      setState(() {
        showThanakyouMassege = false;
      });
    });
  }
}
