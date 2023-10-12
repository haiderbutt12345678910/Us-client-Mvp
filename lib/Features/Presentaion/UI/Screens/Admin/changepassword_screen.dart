import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/AuthCubits/changepassword_cubit.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/StateMangemnet/blocstates.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/Global/customcircularbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminChangePasswordScreen extends StatefulWidget {
  const AdminChangePasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminChangePasswordScreenState createState() =>
      _AdminChangePasswordScreenState();
}

class _AdminChangePasswordScreenState extends State<AdminChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ChangePasswordCubit, BlocStates>(
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

                            SizedBox(height: size.width * .05),

                            // Password Text Field
                            TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'New Password Password',
                                  hintText: "Enter New Password"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field can not be empty';
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
                                'Change Password',
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
              content: Text("Password Chnaged Successfully"),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.of(context).pop();
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
      BlocProvider.of<ChangePasswordCubit>(context)
          .changePassword(_passwordController.text);
    }
  }
}
