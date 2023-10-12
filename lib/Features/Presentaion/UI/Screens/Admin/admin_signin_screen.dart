import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/signin_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/admin_home_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<SignInCubit, BlocStates>(builder: ((context, state) {
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
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  hintText: "Enter Your Email"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                }
                                final emailRegex = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Invalid email format';
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
        }), listener: (ctx, state) {
          if (state is Sucessfull) {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Succesfully Logged In"),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
            );
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
      BlocProvider.of<SignInCubit>(context)
          .logIn(_emailController.text, _passwordController.text);
    }
  }
}
