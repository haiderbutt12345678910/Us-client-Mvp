import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/ManageCharactersAndUsersCubits/readuser_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserSignInScreenState createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() async {
    await BlocProvider.of<ReadUsersCubit>(context).readUsers();

    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder(builder: (ctx, state) {
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

                            TextFormField(
                              controller: _userName,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  hintText: "Enter Your Email"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: size.width * .05),

                            // Password Text Field
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
                                'Sign In',
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
        }),
      ),
    );
  }

  void _submitForm() {
    // function to check wether user creddaentials are correct
    if (_formKey.currentState!.validate()) {
      var list = BlocProvider.of<ReadUsersCubit>(context).readUsersListLocall();
      for (int i = 0; i < list.length; i++) {
        if (list[i].userName == _userName.text &&
            list[i].password == _passwordController.text) {
          var snackBar = const SnackBar(
            duration: Duration(seconds: 1),
            content: Text("Operation Successfull"),
            backgroundColor: Colors.green,
          );

          //  Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
          //   );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          return;
        } else {
          var snackBar = const SnackBar(
            duration: Duration(seconds: 2),
            content: Text("No User Found!"),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }
}
