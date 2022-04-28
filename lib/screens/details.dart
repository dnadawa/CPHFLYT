import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/assign_driver.dart';
import 'package:cphflyt/screens/driver_completion.dart';
import 'package:cphflyt/widgets/add_chip_field.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/chip_field.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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

  DateTime? selectedDate;
  String type = "Privat";
  String packageType = "Mellem pakke";
  String flexibleAdd = "3 dage";
  bool isPacking = true;
  bool isCleaning = true;
  bool isHeavy = true;
  bool isBreakable = true;


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
    var driverController = Provider.of<DriverController>(context, listen: false);
    var userController = Provider.of<UserManagementController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.isAdd?"Add a New Task":widget.request!.id, fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      body: Card(
        margin: EdgeInsets.all(20.w),
        elevation: 8,
        color: Color(0xfffafafa),
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
                          child: LabelInputField(text: "Fornavn *", controller: firstName,enabled: widget.isAdd,),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: LabelInputField(text: "Efternavn *", controller: lastName,enabled: widget.isAdd,),
                        )
                    ),
                  ],
                ),

                ///telephone
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tlf.Nr. *",controller: telephone,enabled: widget.isAdd,keyBoardType: TextInputType.phone,),
                ),

                ///email
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Mail *",controller: email,enabled: widget.isAdd,keyBoardType: TextInputType.emailAddress,),
                ),

                ///type
                widget.isAdd?
                AddChipField(
                  text: 'Privat eller erhverv?',
                  items: [
                    'Privat',
                    'Erhverv',
                  ],
                  onChanged: (value)=>type=value,
                ):
                ChipField(
                  text: 'Privat eller erhverv?',
                  initialValue: [widget.request?.type],
                  items: [
                    MultiSelectItem('Privat', "Privat"),
                    MultiSelectItem('Erhverv', "Erhverv"),
                  ],
                ),

                ///package type
                widget.isAdd?
                  AddChipField(
                    text: 'Hvilken pakke ønsker du tilbud på?',
                    items: [
                      'Mellem pakke',
                      'Stor pakke',
                      'Lille pakke',
                      'Lej flyttemænd'
                    ],
                    onChanged: (value)=>packageType=value,
                  ):
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

                ///date
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: GestureDetector(
                      onTap: () async {
                        if (widget.isAdd){
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021, 1, 1),
                              lastDate: DateTime(2023, 12, 31),
                          );

                          selectedDate = pickedDate;
                          await initializeDateFormatting('da_DK');
                          date.text = DateFormat.yMMMMd('da_DK').format(pickedDate!);
                        }
                      },
                      child: LabelInputField(text: "Hvornår skal du flytte? *",controller: date,)),
                ),

                //show only when adding
                ///from address
                if(!widget.isAdd)
                  Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte fra?", maxLines: null,controller: fromAddress,),
                ),
                ///from add google map button
                if(userController.loggedInUserType == UserType.Driver)
                Center(
                  child: Button(
                      color: Color(0xffE68C36),
                      text: "Show location on map",
                      onPressed: () async => driverController.redirectToGoogleMaps(widget.request!.fromAddress)
                  ),
                ),

                ///to address
                if(!widget.isAdd)
                  Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvor skal du flytte til?", maxLines: null,controller: toAddress,),
                ),
                ///to add google map button
                if(userController.loggedInUserType == UserType.Driver)
                  Center(
                    child: Button(
                        color: Color(0xffE68C36),
                        text: "Show location on map",
                        onPressed: () async => driverController.redirectToGoogleMaps(widget.request!.toAddress)
                    ),
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
                    child: LabelInputField(text: "Adresse *",controller: fromAdd,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer *",controller: fromZip,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By *",controller: fromBy,enabled: widget.isAdd,),
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
                    child: LabelInputField(text: "Adresse *",controller: toAdd,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer *",controller: toZip,enabled: widget.isAdd,),
                  ),
                if(widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By *",controller: toBy,enabled: widget.isAdd,),
                  ),

                ///flexible
                widget.isAdd?
                  AddChipField(
                    text: 'Er flyttedagen fleksibel?',
                    items: [
                      '3 dage',
                      '1 dag',
                      '2 dage',
                      '4 dage',
                      '5 dage',
                      '1 uge+',
                      'Nej',
                    ],
                    onChanged: (value)=>flexibleAdd=value,
                  ):
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: LabelInputField(text: "Er flyttedagen fleksibel?",controller: flexible,),
                  ),


                ///isPacking
                widget.isAdd?
                  AddChipField(
                    text: 'Skal flyttefirmaet stå for nedpakning af dine ting?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    onChanged: (value)=>isPacking = value == 'Ja',
                  ):
                  ChipField(
                  text: 'Skal flyttefirmaet stå for nedpakning af dine ting?',
                  initialValue: [widget.request!.isPacking?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                ///isCleaning
                widget.isAdd?
                  AddChipField(
                    text: 'Vil du have flytterengøring i din nuværende bolig?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    onChanged: (value)=>isCleaning = value == 'Ja',
                  ):
                  ChipField(
                  text: 'Vil du have flytterengøring i din nuværende bolig?',
                  initialValue:  [widget.request!.isCleaning?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                ///isHeavy
                widget.isAdd?
                  AddChipField(
                    text: 'Skal der flyttes særligt tungt inventar?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    onChanged: (value)=>isHeavy = value == 'Ja',
                  ):
                  ChipField(
                  text: 'Skal der flyttes særligt tungt inventar?',
                  initialValue: [widget.request!.isHeavy?"Ja":"Nej"],
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                ///heavy count
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: heavyCount,enabled: widget.isAdd,keyBoardType: TextInputType.number,),
                ),

                ///isBreakable
                widget.isAdd?
                  AddChipField(
                    text: 'Skal der flyttes inventar som nemt kan gå i stykker?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    onChanged: (value)=>isBreakable = value == 'Ja',
                  ):
                  ChipField(
                  text: 'Skal der flyttes inventar som nemt kan gå i stykker?',
                  initialValue: [widget.request!.isBreakable?"Ja":"Nej"],
                  fontSize: 12.sp,
                  items: [
                    MultiSelectItem('Ja', "Ja"),
                    MultiSelectItem('Nej', "Nej"),
                  ],
                ),

                ///break count
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: breakCount,enabled: widget.isAdd,keyBoardType: TextInputType.number,),
                ),

                ///others
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Andre bemærkninger", maxLines: null,controller: others,enabled: widget.isAdd,),
                ),

                /// approve and decline
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

                ///add task
                if (widget.isAdd)
                  Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: SizedBox(
                        width: double.infinity,
                        child: Button(
                            color: kApproved,
                            text: "Add Task",
                            onPressed: (){

                              bool isValidated = firstName.text.isNotEmpty && lastName.text.isNotEmpty && telephone.text.isNotEmpty && email.text.isNotEmpty &&
                                  date.text.isNotEmpty && fromAdd.text.isNotEmpty && fromZip.text.isNotEmpty && fromBy.text.isNotEmpty &&
                                  toAdd.text.isNotEmpty && toZip.text.isNotEmpty && toBy.text.isNotEmpty;

                                if (isValidated){
                                  RequestModel newRequest = RequestModel(
                                      id: "",
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      telePhone: telephone.text,
                                      email: email.text,
                                      type: type,
                                      packageType: packageType,
                                      date: DateFormat('yyyy-MM-dd').format(selectedDate!),
                                      fromAddress: AddressModel(fromAdd.text, fromZip.text, fromBy.text),
                                      toAddress: AddressModel(toAdd.text, toZip.text, toBy.text),
                                      flexible: flexibleAdd,
                                      isPacking: isPacking,
                                      isCleaning: isCleaning,
                                      isHeavy: isHeavy,
                                      heavyCount: heavyCount.text,
                                      isBreakable: isBreakable,
                                      breakCount: breakCount.text,
                                      others: others.text,
                                      status: Filter.Pending
                                  );

                                  Provider.of<DriverAssignController>(context, listen: false).addRequest(newRequest, context);
                                }
                                else {
                                  ToastBar(text: "Please fill required fields!", color: Colors.red).show();
                                }
                            }
                        )
                    ),
                  ),

                ///complete task
                if (userController.loggedInUserType == UserType.Driver)
                  Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: SizedBox(
                        width: double.infinity,
                        child: Button(
                            color: kApproved,
                            text: "Complete Task",
                            onPressed: (){
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => DriverCompletion()));
                            }
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
