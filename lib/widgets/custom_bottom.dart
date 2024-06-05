import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child:  Text(title),
    );
  }
}
