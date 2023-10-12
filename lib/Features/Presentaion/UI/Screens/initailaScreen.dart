// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Widgets/InitialScreenWidgets/slideinbutton_widget.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'Asset/Images/bg.png',
            fit: BoxFit.cover,
          ),
          // Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.width * .1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SlideInButton(
                    backgroundColor: Colors.black,
                    btnId: 'v',
                    text: 'Vote ',
                    borderColor: Colors.white,
                  ),
                  SizedBox(height: size.width * .1),
                  const SlideInButton(
                    borderColor: Colors.white,
                    btnId: 'a',
                    text: 'Admin',
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(height: size.width * .1),
                  const SlideInButton(
                    borderColor: Colors.white,
                    btnId: 'u',
                    text: 'User',
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
