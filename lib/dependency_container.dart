import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/DataSource/RemoteData/firebase_repo_impl.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/DataSource/RemoteData/firebase_repository.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Data/repository_impl.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/changepassword_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/signIn_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/AuthUseCases/signout_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/addcharacteroruser_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/readchracters_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/readusers_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/ManageCharacterAndUsers/updatechracteroruser_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/readvote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/UseCases/VotesUseCases/writevote_usecase.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/changepassword_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signin_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signout_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/addcharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/updatecharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/writevotes_cubit.dart';
import 'package:get_it/get_it.dart';

import 'Features/Domain/repository.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
//bloc
//AuthBlocs

  sl.registerFactory<SignInCubit>(() => SignInCubit(signInUseCase: sl.call()));
  sl.registerFactory<ChangePasswordCubit>(
      () => ChangePasswordCubit(changePasswordUseCase: sl.call()));
  sl.registerFactory<SignOutCubit>(
      () => SignOutCubit(signOutUseCase: sl.call()));

//mangecharacterandusers bloc
  sl.registerFactory<ReadUsersCubit>(
      () => ReadUsersCubit(readUsersUseCase: sl.call()));
  sl.registerFactory<ReadCharactersCubit>(
      () => ReadCharactersCubit(readCharactersUseCase: sl.call()));
  sl.registerFactory<UpdateCharacterOrUserCubit>(
      () => UpdateCharacterOrUserCubit(updateCharacterOrUserCubit: sl.call()));
  sl.registerFactory<AddCharaterOrUserCubit>(
      () => AddCharaterOrUserCubit(addCharacterOrUserUseCase: sl.call()));

  //votesblocs
  sl.registerFactory<ReadVotesCubit>(
      () => ReadVotesCubit(readVoteUseCase: sl.call()));

  sl.registerFactory<WriteVotesCubit>(
      () => WriteVotesCubit(writeDailyVoteUseCase: sl.call()));

//UseCases
//AuthUseCases

  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(repository: sl.call()));

  //manageChrateranduser usecases
  sl.registerLazySingleton<ReadUsersUseCase>(
      () => ReadUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadCharactersUseCase>(
      () => ReadCharactersUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddCharacterOrUserUseCase>(
      () => AddCharacterOrUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateCharacterOrUserUseCase>(
      () => UpdateCharacterOrUserUseCase(repository: sl.call()));

  //votes usescases

  sl.registerLazySingleton<WriteDailyVoteUseCase>(
      () => WriteDailyVoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadVoteUseCase>(
      () => ReadVoteUseCase(repository: sl.call()));

//Repo

  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(firebaseRepository: sl.call()));

  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepoImpl(
      firebaseAuth: sl.call(),
      firebaseFirestore: sl.call(),
      firebaseStorage: sl.call()));

//ExterelSources

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
