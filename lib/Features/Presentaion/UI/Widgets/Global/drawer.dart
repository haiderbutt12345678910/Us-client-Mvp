// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signout_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/MangeChracterAndUsers/ManageChracters/allchracters_Screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/MangeChracterAndUsers/ManageUsers/allusers_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/admin_signin_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/changepassword_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final String drawerId;
  const CustomDrawer({
    Key? key,
    required this.drawerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "Asset/Images/logo.png",
                  fit: BoxFit.contain,
                ),
              )),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: const Text('Manage Users',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllUsersScreen()),
              ); //
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.emoji_emotions,
              color: Colors.black,
            ),
            title: const Text(
              'Manage Chracters',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              // Handle the Settings option.
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllChracterScreeb()),
              ); // Close the drawer.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.password,
              color: Colors.black,
            ),
            title: const Text('Change Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminChangePasswordScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: const Text('SignOut',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              // Handle the Exit option.
              // Close the drawer.
              BlocProvider.of<SignOutCubit>(context).signOut().then((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminSignInScreen()),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
