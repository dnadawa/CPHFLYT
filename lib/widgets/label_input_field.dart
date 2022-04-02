import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelInputField extends StatefulWidget {
  
  final String text;
  final TextInputType keyboard;

  const LabelInputField({required this.text, this.keyboard=TextInputType.text});

  @override
  State<LabelInputField> createState() => _LabelInputFieldState();
}

class _LabelInputFieldState extends State<LabelInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboard,
      enabled: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        labelText: widget.text,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(8.w),
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
