import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/DataSource/RemoteData/firebase_repository.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/Models/VotingModel/character_daily_votes.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/Models/VotingModel/daily_voting_model.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/Models/characater_model.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/Models/user_model.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:intl/intl.dart';

class FirebaseRepoImpl extends FirebaseRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  FirebaseRepoImpl(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage});

  @override
  Future<void> addCharacterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    if (userEntity != null) {
      var userModel = UserModel(
        password: userEntity.password,
        userName: userEntity.userName,
        uid: userEntity.uid,
      ).toJson();

      return await firebaseFirestore
          .collection("Users")
          .doc(userEntity.uid)
          .set(userModel);
    } else {
      firebaseStorage
          .ref("ChracterImages")
          .child("chracterimages/${characterEntity!.uid}")
          .putFile(image as File)
          .then((snapShot) {
        snapShot.ref.getDownloadURL().then((imgUrl) async {
          var characterModel = CharacterModel(
                  imageUrl: imgUrl,
                  name: characterEntity.name,
                  uid: characterEntity.uid)
              .toJson();

          return await firebaseFirestore
              .collection("Characters")
              .doc(characterEntity.uid)
              .set(characterModel);
        });
      });
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    return await firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<List<CharacterEntity>> readChracters() async {
    List<CharacterEntity> listChracterEntity = [];
    await firebaseFirestore.collection("Characters").get().then((value) {
      for (var element in value.docs) {
        var map = element.data();

        listChracterEntity.add(CharacterModel.fromJson(map));
      }
    });

    return listChracterEntity;
  }

  @override
  Future<List<DailyVotesEntity>> readDailyVoteList() async {
    List<DailyVotesEntity> dailyVotesList = [];

    await firebaseFirestore
        .collection("Votes")
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        var map = element.data();

        dailyVotesList.add(DailyVotesModel.fromJson(map));
      }
    });

    return dailyVotesList;
  }

  @override
  Future<List<UserEntity>> readUsers() async {
    List<UserEntity> listOfUsers = [];
    await firebaseFirestore.collection("Users").get().then((value) {
      for (var element in value.docs) {
        var map = element.data();

        listOfUsers.add(UserModel.fromJson(map));
      }
    });

    return listOfUsers;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> updateChracterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    //As there are only three feilds so update methods can update all the feild when called though its not the best practise

    if (userEntity != null) {
      var userModel = UserModel(
        password: userEntity.password,
        userName: userEntity.userName,
        uid: userEntity.uid,
      ).toJson();

      return await firebaseFirestore
          .collection("Users")
          .doc(userEntity.uid)
          .update(userModel);
    } else {
      if (image != null) {
        firebaseStorage
            .ref("ChracterImages")
            .child("chracterimages/${characterEntity!.uid}")
            .putFile(image)
            .then((snapShot) {
          snapShot.ref.getDownloadURL().then((imgUrl) async {
            var characterModel = CharacterModel(
                    imageUrl: imgUrl,
                    name: characterEntity.name,
                    uid: characterEntity.uid)
                .toJson();

            return await firebaseFirestore
                .collection("Characters")
                .doc(characterEntity.uid)
                .update(characterModel);
          });
        });
      } else {
        var characterModel = CharacterModel(
                imageUrl: characterEntity!.imageUrl,
                name: characterEntity.name,
                uid: characterEntity.uid)
            .toJson();

        return await firebaseFirestore
            .collection("Characters")
            .doc(characterEntity.uid)
            .update(characterModel);
      }
    }
  }

  @override
  Future<void> writeVote(String chracterId) async {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yy\\MM\\dd').format(currentDate);

    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;

    String timeOfDay;

    if (currentHour >= 0 && currentHour < 12) {
      timeOfDay = 'm';
    } else if (currentHour >= 12 && currentHour < 17) {
      timeOfDay = 'a';
    } else {
      timeOfDay = 'n';
    }

    await firebaseFirestore
        .collection("Votes")
        .doc(formattedDate)
        .get()
        .then((value) async {
      if (value.exists) {
        var data = value.data();
        var dailyVoteDataModelConverted =
            DailyVotesModel.fromJson(data as Map<String, dynamic>);
        dailyVoteDataModelConverted.totalVotes =
            dailyVoteDataModelConverted.totalVotes! + 1;
        print("correct");

        if (dailyVoteDataModelConverted.charactersDailyVotesList!
            .any((element) => element.characterId == chracterId)) {
          CharacterDailyVotesEntity chracterDailyVoteEntity =
              dailyVoteDataModelConverted.charactersDailyVotesList!
                  .firstWhere((element) => element.characterId == chracterId);
          chracterDailyVoteEntity.characterTotalDailyVotes =
              chracterDailyVoteEntity.characterTotalDailyVotes! + 1;
          if (timeOfDay == "m") {
            chracterDailyVoteEntity.morningVotes =
                chracterDailyVoteEntity.morningVotes! + 1;
          } else if (timeOfDay == "a") {
            chracterDailyVoteEntity.afternoonVotes =
                chracterDailyVoteEntity.afternoonVotes! + 1;
          } else {
            chracterDailyVoteEntity.nightVotes =
                chracterDailyVoteEntity.nightVotes! + 1;
          }
        } else {
          dailyVoteDataModelConverted.charactersDailyVotesList!.add(
              CharacterDailyVotesModel(
                  characterId: chracterId,
                  characterTotalDailyVotes: 1,
                  morningVotes: timeOfDay == "m" ? 1 : 0,
                  afternoonVotes: timeOfDay == "a" ? 1 : 0,
                  nightVotes: timeOfDay == "n" ? 1 : 0));
        }
        var dailyVotesModel = DailyVotesModel(
                date: dailyVoteDataModelConverted.date,
                charactersDailyVotesList:
                    dailyVoteDataModelConverted.charactersDailyVotesList,
                totalVotes: dailyVoteDataModelConverted.totalVotes)
            .toJson();
        await firebaseFirestore
            .collection("Votes")
            .doc(formattedDate)
            .update(dailyVotesModel);
      } else {
        var dailyVoteModel = DailyVotesModel(
            totalVotes: 1,
            date: formattedDate,
            charactersDailyVotesList: [
              CharacterDailyVotesEntity(
                  characterId: chracterId,
                  characterTotalDailyVotes: 1,
                  morningVotes: timeOfDay == "m" ? 1 : 0,
                  afternoonVotes: timeOfDay == "a" ? 1 : 0,
                  nightVotes: timeOfDay == "n" ? 1 : 0)
            ]).toJson();

        await firebaseFirestore
            .collection("Votes")
            .doc(formattedDate)
            .set(dailyVoteModel);
      }
    });
  }
}
