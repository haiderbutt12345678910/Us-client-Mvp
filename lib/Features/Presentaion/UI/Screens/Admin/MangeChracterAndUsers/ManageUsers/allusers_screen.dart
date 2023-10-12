import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/MangeChracterAndUsers/sharedScreens/add_characateroruser.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/MangeChracterAndUsers/sharedScreens/update_chracteroruser.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  List<UserEntity> filteredList = [];
  @override
  void initState() {
    BlocProvider.of<ReadUsersCubit>(context).readUsers().then((value) {
      filteredList =
          BlocProvider.of<ReadUsersCubit>(context).readUsersListLocall();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddChratcterOrUser(
                          id: "u",
                        )),
              );
            },
            label: const Text(
              "Add",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Users'),
        ),
        body: BlocConsumer<ReadUsersCubit, BlocStates>(
          builder: ((context, state) {
            var list =
                BlocProvider.of<ReadUsersCubit>(context).readUsersListLocall();
            return Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[300],
                          ),
                          child: TextField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  filteredList = list;
                                });
                                return;
                              }

                              setState(() {
                                filteredList = list
                                    .where((item) => item.userName!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: filteredList.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "No Data Found!",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : ListView.builder(
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * .03,
                                        vertical: size.width * .05),
                                    child: ListTile(
                                      titleTextStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),

                                      trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateCharacterOrUser(
                                                        id: "u",
                                                        userEntity: UserEntity(
                                                          uid: filteredList[
                                                                  index]
                                                              .uid,
                                                          password:
                                                              filteredList[
                                                                      index]
                                                                  .password,
                                                          userName:
                                                              filteredList[
                                                                      index]
                                                                  .userName,
                                                        ),
                                                        characterEntity: null)),
                                          );
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * .04),
                                        ),
                                      ),

                                      title: Text(filteredList[index].userName
                                          as String),
                                      tileColor: Colors.black,
                                      // You can customize the ListTile further with other properties.
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                if (state is Loading) const CustomCircularBar()
              ],
            );
          }),
          listener: (BuildContext context, BlocStates state) {
            if (state is Sucessfull) {
              filteredList = BlocProvider.of<ReadUsersCubit>(context)
                  .readUsersListLocall();
            }
          },
        ));
  }
}
