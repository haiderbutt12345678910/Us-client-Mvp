import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';

import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/addcharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/updatecharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UpdateCharacterOrUser extends StatefulWidget {
  final String id;
  final UserEntity? userEntity;
  final CharacterEntity? characterEntity;
  const UpdateCharacterOrUser(
      {super.key,
      required this.id,
      required this.userEntity,
      required this.characterEntity});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateCharacterOrUserState createState() => _UpdateCharacterOrUserState();
}

class _UpdateCharacterOrUserState extends State<UpdateCharacterOrUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? image;
  @override
  void dispose() {
    _name.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.id == "u") {
      _name.text = widget.userEntity!.userName as String;
      _passwordController.text = widget.userEntity!.password as String;
    } else {
      _name.text = widget.characterEntity!.name as String;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<UpdateCharacterOrUserCubit, BlocStates>(
            builder: ((context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * .1),
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('Asset/Images/logo.png'),
                            SizedBox(height: size.width * .2),

                            if (widget.id == "c")
                              InkWell(
                                onTap: () {
                                  getFromGallery();
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 100.0,
                                    backgroundImage: image != null
                                        ? FileImage(File(image!.path))
                                        : NetworkImage(
                                            widget.characterEntity!.imageUrl
                                                as String) as ImageProvider),
                              ),

                            TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: widget.id == "u"
                                      ? " UserName"
                                      : " Chracter Name",
                                  hintText: widget.id == "u"
                                      ? "Enter UserName"
                                      : "Enter Chracter Name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: size.width * .05),

                            if (widget.id == "u")
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: "Enter Your Password"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),

                            SizedBox(height: size.width * .05),

                            // Sign In Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: _submitForm,
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * .04),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state is Loading) const CustomCircularBar()
            ],
          );
        }), listener: (ctx, state) {
          if (state is Sucessfull) {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Succesfully Added"),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            if (widget.id == "u") {
              BlocProvider.of<ReadUsersCubit>(context)
                  .readUsers()
                  .then((value) {
                Navigator.of(context).pop();
              });
            } else {
              BlocProvider.of<ReadCharactersCubit>(context)
                  .readCharacters()
                  .then((value) {
                Navigator.of(context).pop();
              });
            }
          }

          if (state is Failure) {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 2),
              content: Text("Some Error Occured! Try Again"),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.id == "u") {
        UserEntity userEntity = UserEntity(
            password: _passwordController.text,
            uid: widget.userEntity!.uid,
            userName: _name.text);
        BlocProvider.of<UpdateCharacterOrUserCubit>(context)
            .updateChracterOrUser(userEntity, null, null);
      } else {
        if (image == null) {
          CharacterEntity characterEntity = CharacterEntity(
              imageUrl: widget.characterEntity!.imageUrl,
              uid: widget.characterEntity!.uid,
              name: _name.text);
          BlocProvider.of<UpdateCharacterOrUserCubit>(context)
              .updateChracterOrUser(null, characterEntity, image);
        } else {
          CharacterEntity characterEntity = CharacterEntity(
              imageUrl: "", uid: widget.characterEntity!.uid, name: _name.text);
          BlocProvider.of<UpdateCharacterOrUserCubit>(context)
              .updateChracterOrUser(null, characterEntity, image);
        }
      }
    }
  }

  //for chracter only
  getFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 10,
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
