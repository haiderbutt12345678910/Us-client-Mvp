import 'package:flutter/material.dart';

class CustomCircularBar extends StatelessWidget {
  const CustomCircularBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width,
      height: size.height,
      color: Colors.white.withOpacity(.4),
      child: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.black,
      ),
    );
  }
}
