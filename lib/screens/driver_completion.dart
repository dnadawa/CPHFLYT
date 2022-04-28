import 'dart:io';
import 'dart:typed_data';

import 'package:cphflyt/services/storage_service.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:cphflyt/widgets/signature_pad.dart';
import 'package:cphflyt/widgets/upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../constants.dart';

class DriverCompletion extends StatelessWidget {
  final bool isAdd;

  DriverCompletion({this.isAdd=true});

  TextEditingController taskNumber = TextEditingController();
  TextEditingController given = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  TextEditingController numberOfHours = TextEditingController();
  TextEditingController paymentType = TextEditingController();
  TextEditingController heavyLifting = TextEditingController();
  TextEditingController garbage = TextEditingController();
  TextEditingController storage = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController customerName = TextEditingController();
  Uint8List? driverSignature;
  Uint8List? customerSignature;
  File? image1, image2, image3, image4, image5, image6, image7, image8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Complete Task", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      body: Card(
          color: Color(0xffFAFAFA),
          margin: EdgeInsets.all(20.w),
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)
          ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [

                ///task number
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Opgave nummer",enabled: isAdd,controller: taskNumber,),
                ),

                ///given
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Dato",enabled: isAdd,controller: given,),
                ),

                ///start time
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Start tidspunkt",enabled: isAdd,controller: startTime,),
                ),

                ///end time
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Slut tidspunkt",enabled: isAdd,controller: endTime,),
                ),

                ///hourly rate
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Timepris",enabled: isAdd,controller: hourlyRate,),
                ),

                ///num of hours
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Antal timer",enabled: isAdd,controller: numberOfHours,),
                ),

                ///payemnt type
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Betalingstype",enabled: isAdd,controller: paymentType,),
                ),

                ///heavy lifting
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tungløft",enabled: isAdd,controller: heavyLifting,),
                ),

                ///garbage
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Skrald",enabled: isAdd,controller: garbage,),
                ),

                ///storage
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Opbevaring",enabled: isAdd,controller: storage,),
                ),

                ///total amount
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Samlet beløb",enabled: isAdd,controller: total,),
                ),


                UploadWidget(title: "Vedhæft 1",pickImage: (img)=> image1 = img),
                UploadWidget(title: "Vedhæft 2",pickImage: (img)=> image2 = img),
                UploadWidget(title: "Vedhæft 3",pickImage: (img)=> image3 = img),
                UploadWidget(title: "Vedhæft 4",pickImage: (img)=> image4 = img),
                UploadWidget(title: "Vedhæft 5",pickImage: (img)=> image5 = img),
                UploadWidget(title: "Vedhæft 6",pickImage: (img)=> image6 = img),
                UploadWidget(title: "Vedhæft 7",pickImage: (img)=> image7 = img),
                UploadWidget(title: "Vedhæft 8",pickImage: (img)=> image8 = img),

                ///driver name
                SignaturePad(
                    isAdd: isAdd,
                    textEditingController: driverName,
                    hint: "Medarbejders Navn",
                    buttonText: "Medarbejders Underskrift",
                    onComplete: (Uint8List? imageBytes){
                        driverSignature = imageBytes;
                    },
                ),

                ///customer name
                SignaturePad(
                    isAdd: isAdd,
                    textEditingController: customerName,
                    hint: "Kundens Navn",
                    buttonText: "Kundens Underskrift",
                    onComplete: (Uint8List? imageBytes){
                        customerSignature = imageBytes;
                    },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: SizedBox(
                      width: double.infinity,
                      child: Button(
                        color: kApproved,
                        text: "Submit",
                        onPressed: () async {
                          // var storageService = Provider.of<StorageService>(context, listen: false);
                          //
                          // String url = await storageService.uploadBytes(customerName.text.replaceAll(' ', '_'), customerSignature!);
                          // print(url);

                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              content: Image.file(image1!),
                            );
                          });
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
