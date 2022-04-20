import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/assign_driver.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Details extends StatefulWidget {

  final RequestModel request;

  const Details({required this.request});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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

  @override
  void initState() {
    super.initState();

    firstName.text = widget.request.firstName;
    lastName.text = widget.request.lastName;
    telephone.text = widget.request.telePhone;
    email.text = widget.request.email;
    date.text = widget.request.date;
    fromAddress.text = widget.request.fromAddress.getAddressAsString();
    toAddress.text = widget.request.toAddress.getAddressAsString();
    flexible.text = widget.request.flexible;
    heavyCount.text = widget.request.heavyCount;
    breakCount.text = widget.request.breakCount;
    others.text = widget.request.others;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.request.id, fontSize: 22.sp, isBold: true,color: Colors.white,),
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
              children: [
                SizedBox(height: 10.h,),
                ///name
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: LabelInputField(text: "Fornavn", controller: firstName,),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: LabelInputField(text: "Efternavn", controller: lastName,),
                        )
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tlf.Nr.",controller: telephone,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Mail",controller: email,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Privat eller erhverv?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.type],
                      items: [
                        MultiSelectItem('Privat', "Privat"),
                        MultiSelectItem('Erhverv', "Erhverv"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Hvilken pakke ønsker du tilbud på?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.packageType],
                      items: [
                        MultiSelectItem('Mellem pakke', "Mellem pakke"),
                        MultiSelectItem('Stor pakke', "Stor pakke"),
                        MultiSelectItem('Lille pakke', "Lille pakke"),
                        MultiSelectItem('Lej flyttemænd', "Lej flyttemænd"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvornår skal du flytte?",controller: date,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte fra?", maxLines: null,controller: fromAddress,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte til?", maxLines: null,controller: toAddress,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Er flyttedagen fleksibel?",controller: flexible,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Skal flyttefirmaet stå for nedpakning af dine ting?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.isPacking?"Ja":"Nej"],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Vil du have flytterengøring i din nuværende bolig?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.isCleaning?"Ja":"Nej"],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Skal der flyttes særligt tungt inventar?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.isHeavy?"Ja":"Nej"],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: heavyCount,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Skal der flyttes inventar som nemt kan gå i stykker?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: [widget.request.isBreakable?"Ja":"Nej"],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: breakCount,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Andre bemærkninger", maxLines: null,controller: others,),
                ),

                if (widget.request.status == Filter.Pending)
                  Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: Button(color: kApproved, text: "Approve", onPressed: (){}),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Button(color: kDeclined, text: "Decline", onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AssignDriver();
                            }
                          );
                        }),
                      ),
                    ],
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
