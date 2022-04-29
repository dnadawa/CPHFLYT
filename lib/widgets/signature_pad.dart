import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';
import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';

class SignaturePad extends StatelessWidget {

  final bool isAdd;
  final TextEditingController textEditingController;
  final String hint;
  final String buttonText;
  final Function onComplete;
  final String? image;

  const SignaturePad({required this.isAdd,required this.textEditingController,required this.hint,required this.buttonText,required this.onComplete, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: Container(
        margin: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              LabelInputField(text: hint,enabled: isAdd,controller: textEditingController,),
              SizedBox(height: 20.h),

              isAdd?
              SizedBox(
                width: double.infinity,
                child: Button(
                    color: kLightBlue,
                    text: buttonText,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            final SignatureController _controller = SignatureController(
                              penStrokeWidth: 5,
                              penColor: Colors.black,
                              exportBackgroundColor: Color(0xfff5f5f5),
                            );

                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)
                              ),
                              contentPadding: EdgeInsets.zero,
                              insetPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
                              content: SizedBox(
                                width: 1.sw,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))
                                      ),
                                      child: CustomText(
                                        text: 'Enter your signature',
                                        color: Colors.white,
                                        isBold: true,
                                        fontSize: 28.sp,
                                        align: TextAlign.center,
                                      ),
                                    ),

                                    Signature(
                                      controller: _controller,
                                      width: double.infinity,
                                      height: 0.6.sh,
                                      backgroundColor: Color(0xfff5f5f5),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Button(
                                                color: kDeclined,
                                                text: 'Clear',
                                                onPressed: ()=>_controller.clear(),
                                              )
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                              child: Button(
                                                color: kApproved,
                                                text: 'Done',
                                                onPressed: () async {
                                                  Uint8List? signBytes = await _controller.toPngBytes();
                                                  onComplete(signBytes);
                                                  Navigator.pop(context);
                                                },
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
              ):
              Image.network(image!)
              ,
            ],
          ),
        ),
      ),
    );
  }
}
