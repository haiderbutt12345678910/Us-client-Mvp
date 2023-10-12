import 'dart:io';

import 'package:flutter_application_assignmnettechnilify/Features/Data/DataSource/RemoteData/firebase_repository.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/user_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/repository.dart';

class RepositoryImpl extends Repository {
  final FirebaseRepository firebaseRepository;

  RepositoryImpl({required this.firebaseRepository});

  @override
  Future<void> addCharacterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    return await firebaseRepository.addCharacterOrUser(
        userEntity, characterEntity, image);
  }

  @override
  Future<void> changePassword(String newPassword) async {
    return await firebaseRepository.changePassword(newPassword);
  }

  @override
  Future<List<CharacterEntity>> readCharacters() async {
    return await firebaseRepository.readChracters();
  }

  @override
  Future<List<DailyVotesEntity>> readDailyVoteList() async {
    return await firebaseRepository.readDailyVoteList();
  }

  @override
  Future<List<UserEntity>> readUsers() async {
    return await firebaseRepository.readUsers();
  }

  @override
  Future<void> signIn(String email, String password) async {
    return await firebaseRepository.signIn(email, password);
  }

  @override
  Future<void> signOut() async {
    return await firebaseRepository.signOut();
  }

  @override
  Future<void> updateChracterOrUser(UserEntity? userEntity,
      CharacterEntity? characterEntity, File? image) async {
    return await firebaseRepository.updateChracterOrUser(
        userEntity, characterEntity, image);
  }

  @override
  Future<void> writeVote(String chracterId) async {
    return await firebaseRepository.writeVote(chracterId);
  }
}
