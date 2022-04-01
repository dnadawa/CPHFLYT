import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {

  final bool isPassword;
  final String text;
  final IconData icon;
  final TextInputType keyboard;

  const InputField({this.isPassword=false,required this.text, required this.icon, this.keyboard=TextInputType.text});

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
