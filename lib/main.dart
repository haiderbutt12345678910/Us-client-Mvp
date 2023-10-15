import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/changepassword_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signin_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signout_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/addcharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readcharacters_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/updatecharacteroruser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/readvotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/VotesCubits/writevotes_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/Reports/charcatervotedata_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/Reports/popularirydata_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/splash_screen.dart';
import 'package:flutter_application_assignmnettechnilify/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dependency_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Auth
        BlocProvider<SignInCubit>(create: (_) => di.sl<SignInCubit>()),
        BlocProvider<SignOutCubit>(create: (_) => di.sl<SignOutCubit>()),
        BlocProvider<ChangePasswordCubit>(
            create: (_) => di.sl<ChangePasswordCubit>()),
        //mangeChracteradusers
        BlocProvider<ReadUsersCubit>(create: (_) => di.sl<ReadUsersCubit>()),
        BlocProvider<ReadCharactersCubit>(
            create: (_) => di.sl<ReadCharactersCubit>()),
        BlocProvider<UpdateCharacterOrUserCubit>(
            create: (_) => di.sl<UpdateCharacterOrUserCubit>()),

        BlocProvider<AddCharaterOrUserCubit>(
            create: (_) => di.sl<AddCharaterOrUserCubit>()),

        // votes
        BlocProvider<ReadVotesCubit>(create: (_) => di.sl<ReadVotesCubit>()),

        BlocProvider<WriteVotesCubit>(create: (_) => di.sl<WriteVotesCubit>()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
