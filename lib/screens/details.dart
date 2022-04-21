import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/assign_driver.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/chip_field.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {

  final RequestModel? request;
  final bool isAdd;

  const Details({this.request, this.isAdd=false});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  //when viewing
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController fromAddress = TextEditingController();
  TextEditingController toAddress = TextEditingController();
  TextEditingController flexible = TextEditingController();
  TextEditingController heavyCount = TextEditingController();
  TextEditingController breakCount = TextEditingController();
  TextEditingController others = TextEditingController();

  //when adding
  TextEditingController fromAdd = TextEditingController();
  TextEditingController fromZip = TextEditingController();
  TextEditingController fromBy = TextEditingController();
  TextEditingController toAdd = TextEditingController();
  TextEditingController toZip = TextEditingController();
  TextEditingController toBy = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstName.text = widget.request?.firstName ?? "";
    lastName.text = widget.request?.lastName ?? "";
    telephone.text = widget.request?.telePhone ?? "";
    email.text = widget.request?.email ?? "";
    date.text = widget.request?.date ?? "";
    fromAddress.text = widget.request?.fromAddress.getAddressAsString() ?? "";
    toAddress.text = widget.request?.toAddress.getAddressAsString() ?? "";
    flexible.text = widget.request?.flexible ?? "";
    heavyCount.text = widget.request?.heavyCount ?? "";
    breakCount.text = widget.request?.breakCount ?? "";
    others.text = widget.request?.others ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.isAdd?"Add a New Task":widget.request!.id, fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      body: Card(
        margin: EdgeInsets.all(20.w),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r)
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                ///name
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: LabelInputField(text: "Fornavn", controller: firstName,enabled: widget.isAdd,),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: LabelInputField(text: "Efternavn", controller: lastName,enabled: widget.isAdd,),
                        )
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tlf.Nr.",controller: telephone,enabled: widget.isAdd,keyBoardType: TextInputType.phone,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Mail",controller: email,enabled: widget.isAdd,keyBoardType: TextInputType.emailAddress,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                      color: Color(0xff1470AF),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Text("Privat eller erhverv?",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    width: double.infinity,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                    border: Border.all(color: Color(0xff5B9AC6),width: 4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff1470AF),width: 2),
                          color: Color(0xff1470AF),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 30.w),
                          child: Text("Privat",
                            style: TextStyle(
                                color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff5B9AC6),width: 2),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 30.w),
                          child: Text("Erhverv"),
                        ),
                      ),
                    ],
                  ),
                ),
                ChipField(
                    text: 'Hvilken pakke ønsker du tilbud på?',
                    initialValue: [widget.request?.packageType],
                    items: [
                      MultiSelectItem('Mellem pakke', "Mellem pakke"),
                      MultiSelectItem('Stor pakke', "Stor pakke"),
                      MultiSelectItem('Lille pakke', "Lille pakke"),
                      MultiSelectItem('Lej flyttemænd', "Lej flyttemænd"),
                    ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvornår skal du flytte?",controller: date,enabled: widget.isAdd,),
                ),

                //show only when adding
                if(!widget.isAdd)
                  Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte fra?", maxLines: null,controller: fromAddress,),
                ),
                if(!widget.isAdd)
                  Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte til?", maxLines: null,controller: toAddress,),
                ),

                //show only when viewing
                /// FROM ADDRESS
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: CustomText(text: "Hvor skal du flytte fra?",isBold: true),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Adresse",controller: fromAdd,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer",controller: fromZip,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By",controller: fromBy,enabled: widget.isAdd,),
                  ),


                /// TO ADDRESS
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: CustomText(text: "Hvor skal du flytte til?",isBold: true),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Adresse",controller: toAdd,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer",controller: toZip,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By",controller: toBy,enabled: widget.isAdd,),
                  ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Er flyttedagen fleksibel?",controller: flexible,),
                ),
                ChipField(
                  text: 'Skal flyttefirmaet stå for nedpakning af dine ting?',
                  initialValue: widget.isAdd?null:[widget.request!.isPacking?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),
                ChipField(
                  text: 'Vil du have flytterengøring i din nuværende bolig?',
                  initialValue:  widget.isAdd?null:[widget.request!.isCleaning?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),
                ChipField(
                  text: 'Skal der flyttes særligt tungt inventar?',
                  initialValue: widget.isAdd?null:[widget.request!.isHeavy?"Ja":"Nej"],
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: heavyCount,enabled: widget.isAdd,keyBoardType: TextInputType.number,),
                ),
                ChipField(
                  text: 'Skal der flyttes inventar som nemt kan gå i stykker?',
                  initialValue: widget.isAdd?null:[widget.request!.isBreakable?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: breakCount,enabled: widget.isAdd,keyBoardType: TextInputType.number,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Andre bemærkninger", maxLines: null,controller: others,enabled: widget.isAdd,),
                ),

                if (!widget.isAdd && widget.request!.status == Filter.Pending)
                  Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: Button(color: kApproved, text: "Approve", onPressed: ()=>showDialog(
                              context: context,
                              builder: (BuildContext context) => AssignDriver(requestID: widget.request!.id))
                          ),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Button(color: kDeclined, text: "Decline", onPressed: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              content: CustomText(text: "Are you sure you want to decline this request?"),
                              actions: [
                                TextButton(onPressed: ()=>Provider.of<DriverAssignController>(context, listen: false).trashRequest(widget.request!.id, context), child: CustomText(text: "Yes")),
                                TextButton(onPressed: ()=>Navigator.pop(context), child: CustomText(text: "No")),
                              ],
                            );
                          });
                        })
                      ),
                    ],
                  ),
                ),

                if (widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: SizedBox(
                        width: double.infinity,
                        child: Button(color: kApproved, text: "Add Task", onPressed: (){}
                        )
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
