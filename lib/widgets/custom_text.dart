import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double? fontSize;
  final bool isBold;
  final Color color;

  const CustomText({required this.text,this.fontSize, this.isBold=false, this.color=Colors.black});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold?FontWeight.bold:FontWeight.normal,
        color: color,
      ),
    );
  }
}
