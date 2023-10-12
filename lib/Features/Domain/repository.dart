import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';

abstract class Repository {
  //authentaiction for admins
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> changePassword(String newPassword);

//Fecth Reports
//MultiPurpoes Function
  //1.used to read the all the data if parameters are passed with null values(contains info about total votes daily for voting dates,contains data for specific charaters for all dates and for single date,
  //Also be used to rank chrater for top 5 chracter functionality,)
  //2.used to read the data from period

  Future<List<DailyVotesEntity>> readDailyVoteList();
  //write votes

  Future<void> writeVote(String chracterId);

  //CRUD
  //For updating and adding features for Managing Chracters and Users same functions are used(Functions are differnrtaitiated based on the Prams values passed)
  //the file param is used for uploaing chratcer image from device
  Future<void> updateChracterOrUser(
      UserEntity? userEntity, CharacterEntity? characterEntity, File? image);
  Future<void> addCharacterOrUser(
      UserEntity? userEntity, CharacterEntity? characterEntity, File? image);

  Future<List<UserEntity>> readUsers();

  Future<List<CharacterEntity>> readCharacters();
}
