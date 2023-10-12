import 'package:flutter/material.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/Admin/admin_signin_screen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/User/user_signin_screeen.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Presentaion/UI/Screens/voting_screen.dart';

class SlideInButton extends StatefulWidget {
  final String text;
  final Color borderColor;
  final Color backgroundColor;
  final String btnId;

  const SlideInButton({
    super.key,
    required this.text,
    required this.btnId,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SlideInButtonState createState() => _SlideInButtonState();
}

class _SlideInButtonState extends State<SlideInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SlideTransition(
      position: _slideAnimation,
      child: InkWell(
        onTap: () {
          if (widget.btnId == "v") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VotingScreen()),
            );
          } else if (widget.btnId == "a") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminSignInScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserSignInScreen()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * .1,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .03, vertical: size.width * .03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.borderColor, width: 2),
            color: widget.backgroundColor,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
