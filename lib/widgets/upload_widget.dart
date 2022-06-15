import 'dart:io';

import 'package:cphflyt/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cphflyt/constants.dart';

class UploadWidget extends StatelessWidget {
  final String title;
  final Function pickImage;
  final bool isAdd;
  final String? image;

  const UploadWidget({required this.title,required this.pickImage,required this.isAdd, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              color: kPrimaryColor,
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
            border: Border.all(color: kPrimaryColor, width: 4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: isAdd?0:12.w),
            child: Center(
              child: isAdd?
              Button(
                  color: kInactiveBackgroundColor,
                  text: "Choose File",
                  textColor: Colors.black,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                    if(image != null) {
                       pickImage(File(image.path));
                    }
                  }
              ):
              Image.network(image!, fit: BoxFit.cover,),
            ),
          ),
        ),
      ],
    );
  }
}
