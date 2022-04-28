import 'dart:io';

import 'package:cphflyt/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadWidget extends StatelessWidget {
  final String title;
  final Function pickImage;

  const UploadWidget({required this.title,required this.pickImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              color: Color(0xff0D47A1),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            width: double.infinity,
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
            border: Border.all(color: Color(0xff0D47A1), width: 4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: Button(
                  color: Color(0xffE0E0E0),
                  text: "Choose File",
                  textColor: Colors.black,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                    if(image != null) {
                       pickImage(File(image.path));
                    }
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }
}
