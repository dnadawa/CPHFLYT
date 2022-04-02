import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Task #1234", fontSize: 22.sp, isBold: true,color: Colors.white,),
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
                ///name
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: LabelInputField(text: "Fornavn"),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: LabelInputField(text: "Efternavn"),
                        )
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tlf.Nr."),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Mail"),
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
                      initialValue: ['Privat'],
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
                      initialValue: ['Mellem pakke'],
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
                  child: LabelInputField(text: "Hvornår skal du flytte?"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte fra?", maxLines: null,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte til?", maxLines: null,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Er flyttedagen fleksibel?"),
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
                      initialValue: ['Ja'],
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
                      initialValue: ['Ja'],
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
                      title: Text('Skal der flyttes særligt tungt inventar?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: ['Ja'],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: MultiSelectChipField(
                      searchable: false,
                      title: Text('Skal der flyttes inventar som nemt kan gå i stykker?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11.5.sp),),
                      chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor,width: 3),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      selectedChipColor: Theme.of(context).primaryColor,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      scroll: false,
                      initialValue: ['Ja'],
                      items: [
                        MultiSelectItem('Ja', "Ja"),
                        MultiSelectItem('Nej', "Nej"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Andre bemærkninger", maxLines: null,),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: Button(color: kApproved, text: "Approve", onPressed: (){}),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Button(color: kDeclined, text: "Decline", onPressed: (){}),
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
