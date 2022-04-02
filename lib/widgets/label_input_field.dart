import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelInputField extends StatelessWidget {
  
  final String text;
  final int? maxLines;

  const LabelInputField({required this.text, this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      maxLines: maxLines,
      textAlign: maxLines==1?TextAlign.center:TextAlign.left,
      decoration: InputDecoration(
        filled: true,
        labelText: text,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        ),
      ),
    );
  }
}
