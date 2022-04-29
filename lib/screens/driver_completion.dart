import 'dart:io';
import 'dart:typed_data';

import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/models/completion_model.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:cphflyt/widgets/signature_pad.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:cphflyt/widgets/upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cphflyt/constants.dart';
import 'package:provider/provider.dart';

class DriverCompletion extends StatefulWidget {
  final bool isAdd;
  final String taskID;
  final CompleteTask? completeTask;

  const DriverCompletion({this.isAdd=true,required this.taskID, this.completeTask});

  @override
  State<DriverCompletion> createState() => _DriverCompletionState();
}

class _DriverCompletionState extends State<DriverCompletion> {

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
  void initState() {
    super.initState();
    taskNumber.text = widget.taskID;
    given.text = widget.completeTask?.given ?? "";
    startTime.text = widget.completeTask?.startTime ?? "";
    endTime.text = widget.completeTask?.endTime ?? "";
    hourlyRate.text = widget.completeTask?.hourlyRate ?? "";
    numberOfHours.text = widget.completeTask?.numberOfHours ?? "";
    paymentType.text = widget.completeTask?.paymentType ?? "";
    heavyLifting.text = widget.completeTask?.heavyLifting ?? "";
    garbage.text = widget.completeTask?.garbage ?? "";
    storage.text = widget.completeTask?.storage ?? "";
    total.text = widget.completeTask?.total ?? "";
    driverName.text = widget.completeTask?.driverName ?? "";
    customerName.text = widget.completeTask?.customerName ?? "";
  }

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
                  child: LabelInputField(text: "Opgave nummer",enabled: false,controller: taskNumber,),
                ),

                ///given
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Dato",enabled: widget.isAdd,controller: given,),
                ),

                ///start time
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Start tidspunkt",enabled: widget.isAdd,controller: startTime,),
                ),

                ///end time
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Slut tidspunkt",enabled: widget.isAdd,controller: endTime,),
                ),

                ///hourly rate
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Timepris",enabled: widget.isAdd,controller: hourlyRate,keyBoardType: TextInputType.number),
                ),

                ///num of hours
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Antal timer",enabled: widget.isAdd,controller: numberOfHours,keyBoardType: TextInputType.number),
                ),

                ///payemnt type
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Betalingstype",enabled: widget.isAdd,controller: paymentType,),
                ),

                ///heavy lifting
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tungløft",enabled: widget.isAdd,controller: heavyLifting,),
                ),

                ///garbage
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Skrald",enabled: widget.isAdd,controller: garbage,),
                ),

                ///storage
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Opbevaring",enabled: widget.isAdd,controller: storage,),
                ),

                ///total amount
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Samlet beløb",enabled: widget.isAdd,controller: total,keyBoardType: TextInputType.number),
                ),

                if (widget.isAdd || widget.completeTask!.image1.isNotEmpty)
                UploadWidget(title: "Vedhæft 1",pickImage: (img)=> image1 = img, isAdd: widget.isAdd, image: widget.completeTask?.image1,),
                if (widget.isAdd || widget.completeTask!.image2.isNotEmpty)
                UploadWidget(title: "Vedhæft 2",pickImage: (img)=> image2 = img, isAdd: widget.isAdd, image: widget.completeTask?.image2,),
                if (widget.isAdd || widget.completeTask!.image3.isNotEmpty)
                UploadWidget(title: "Vedhæft 3",pickImage: (img)=> image3 = img, isAdd: widget.isAdd, image: widget.completeTask?.image3,),
                if (widget.isAdd || widget.completeTask!.image4.isNotEmpty)
                UploadWidget(title: "Vedhæft 4",pickImage: (img)=> image4 = img, isAdd: widget.isAdd, image: widget.completeTask?.image4,),
                if (widget.isAdd || widget.completeTask!.image5.isNotEmpty)
                UploadWidget(title: "Vedhæft 5",pickImage: (img)=> image5 = img, isAdd: widget.isAdd, image: widget.completeTask?.image5,),
                if (widget.isAdd || widget.completeTask!.image6.isNotEmpty)
                UploadWidget(title: "Vedhæft 6",pickImage: (img)=> image6 = img, isAdd: widget.isAdd, image: widget.completeTask?.image6,),
                if (widget.isAdd || widget.completeTask!.image7.isNotEmpty)
                UploadWidget(title: "Vedhæft 7",pickImage: (img)=> image7 = img, isAdd: widget.isAdd, image: widget.completeTask?.image7,),
                if (widget.isAdd || widget.completeTask!.image8.isNotEmpty)
                UploadWidget(title: "Vedhæft 8",pickImage: (img)=> image8 = img, isAdd: widget.isAdd, image: widget.completeTask?.image8,),

                ///driver name
                SignaturePad(
                    isAdd: widget.isAdd,
                    textEditingController: driverName,
                    hint: "Medarbejders Navn",
                    buttonText: "Medarbejders Underskrift",
                    image: widget.completeTask?.driverSign,
                    onComplete: (Uint8List? imageBytes){
                        driverSignature = imageBytes;
                    },
                ),

                ///customer name
                SignaturePad(
                    isAdd: widget.isAdd,
                    textEditingController: customerName,
                    hint: "Kundens Navn",
                    buttonText: "Kundens Underskrift",
                  image: widget.completeTask?.customerSign,
                    onComplete: (Uint8List? imageBytes){
                        customerSignature = imageBytes;
                    },
                ),

                if (widget.isAdd)
                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: SizedBox(
                      width: double.infinity,
                      child: Button(
                        color: kApproved,
                        text: "Submit",
                        onPressed: () async {
                          if (startTime.text.isNotEmpty && endTime.text.isNotEmpty && driverName.text.isNotEmpty && customerName.text.isNotEmpty && driverSignature != null && customerSignature != null){
                            Provider.of<DriverController>(context, listen: false).completeTask(
                                customerSign: customerSignature!,
                                driverSign: driverSignature!,
                                customerName: customerName.text,
                                driverName: driverName.text,
                                images: [image1, image2, image3, image4, image5, image6, image7, image8],
                                taskID: taskNumber.text,
                                given: given.text,
                                startTime: startTime.text,
                                endTime: endTime.text,
                                hourlyRate: hourlyRate.text,
                                numOfHours: numberOfHours.text,
                                paymentType: paymentType.text,
                                heavyLifting: heavyLifting.text,
                                garbage: garbage.text,
                                storage: storage.text,
                                total: total.text,
                                context: context
                            );
                          }
                          else {
                            ToastBar(text: "Please fill required fields and sign!", color: Colors.red).show();
                          }
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
