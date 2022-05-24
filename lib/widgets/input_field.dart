import 'package:cphflyt/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {

  final bool isPassword;
  final String text;
  final IconData icon;
  final TextInputType keyboard;
  final bool isBorder;
  final TextEditingController? controller;

  const InputField({this.isPassword=false,required this.text, required this.icon, this.keyboard=TextInputType.text, this.isBorder=true, this.controller});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  late bool _hideText;

  @override
  void initState() {
    super.initState();
    _hideText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _hideText,
      keyboardType: widget.keyboard,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.text,
        prefixIcon: Icon(widget.icon,color: Theme.of(context).primaryColor,),
        suffixIcon: widget.isPassword?IconButton(
          onPressed: (){
            setState(() {
              _hideText = !_hideText;
            });
          },
          icon: Icon(_hideText?Icons.visibility_off:Icons.visibility),
        ):null,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: widget.isBorder?BorderSide(width: 2,color: kInactiveBackgroundColor):BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: widget.isBorder?BorderSide(width: 2,color: Theme.of(context).primaryColor):BorderSide.none,
        ),
      ),
    );
  }
}
