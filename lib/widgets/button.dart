import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {

  final Color color;
  final String text;
  final Color textColor;
  final Function() onPressed;

  const Button({required this.color,required this.text,required this.onPressed, this.textColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
          )
      ),
      child: CustomText(text: text,color: textColor,isBold: true,fontSize: 20.sp,),
    );
  }
}
