import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/address_model.dart';
import 'package:cphflyt/models/completion_model.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/assign_driver.dart';
import 'package:cphflyt/screens/driver_completion.dart';
import 'package:cphflyt/widgets/chip_field.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {

  final RequestModel? request;
  final bool isAdd;
  final bool isCompleted;

  const Details({this.request, this.isAdd=false, this.isCompleted=false});

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

  late String type;
  late String packageType;
  late bool isPacking;
  late bool isCleaning;
  late bool isHeavy;
  late bool isBreakable;
  late bool isEdit;

  setAddress(TextEditingController controller, AddressModel addressModel){
    controller.text = addressModel.getAddressAsString();
  }

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
    flexible.text = widget.request?.flexible ?? "3 dage";
    heavyCount.text = widget.request?.heavyCount ?? "";
    breakCount.text = widget.request?.breakCount ?? "";
    others.text = widget.request?.others ?? "";
    isEdit = widget.isAdd;

    fromAdd.text = widget.request?.fromAddress.address ?? "";
    fromZip.text = widget.request?.fromAddress.zip ?? "";
    fromBy.text = widget.request?.fromAddress.by ?? "";

    toAdd.text = widget.request?.toAddress.address ?? "";
    toZip.text = widget.request?.toAddress.zip ?? "";
    toBy.text = widget.request?.toAddress.by ?? "";

    type = widget.request?.type ?? "Privat";
    packageType = widget.request?.packageType ?? "Mellem pakke";
    isPacking = widget.request?.isPacking ?? true;
    isCleaning = widget.request?.isCleaning ?? true;
    isHeavy = widget.request?.isHeavy ?? true;
    isBreakable = widget.request?.isBreakable ?? true;

  }

  @override
  Widget build(BuildContext context) {
    var driverController = Provider.of<DriverController>(context, listen: false);
    var userController = Provider.of<UserManagementController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.isAdd?"Add a New Task":widget.request!.id, fontSize: 22.sp, isBold: true,color: Colors.white,),
        actions: [
          if(!widget.isAdd && userController.loggedInUserType != UserType.Driver)
            IconButton(
                onPressed: (){
                  setState(() {
                    isEdit = !isEdit;
                  });

                  if (!isEdit){
                    setAddress(fromAddress, AddressModel(fromAdd.text, fromZip.text, fromBy.text));
                    setAddress(toAddress, AddressModel(toAdd.text, toZip.text, toBy.text));
                    addEditTask(isEdit: true);
                  }
                },
                icon: Icon(isEdit ? Icons.check : Icons.edit)
            )
        ],
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
                          child: LabelInputField(text: "Fornavn *", controller: firstName,enabled: isEdit,),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: LabelInputField(text: "Efternavn *", controller: lastName,enabled: isEdit,),
                        )
                    ),
                  ],
                ),

                ///telephone
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tlf.Nr. *",controller: telephone,enabled: isEdit,keyBoardType: TextInputType.phone,),
                ),

                ///email
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Mail *",controller: email,enabled: isEdit,keyBoardType: TextInputType.emailAddress,),
                ),

                ///type
                ChipField(
                  isAdd: isEdit,
                  text: 'Privat eller erhverv?',
                  items: [
                    'Privat',
                    'Erhverv',
                  ],
                  initialItem: type,
                  onChanged: (value)=>type=value,
                ),

                ///package type
                ChipField(
                    isAdd: isEdit,
                    text: 'Hvilken pakke ønsker du tilbud på?',
                    items: [
                      'Mellem pakke',
                      'Stor pakke',
                      'Lille pakke',
                      'Lej flyttemænd'
                    ],
                    initialItem: packageType,
                    onChanged: (value)=>packageType=value,
                  ),

                ///date
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: GestureDetector(
                      onTap: () async {
                        if (isEdit){
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021, 1, 1),
                              lastDate: DateTime(2023, 12, 31),
                          );

                          await initializeDateFormatting('da_DK');
                          date.text = DateFormat.yMMMMd('da_DK').format(pickedDate!);
                        }
                      },
                      child: LabelInputField(text: "Hvornår skal du flytte? *",controller: date,)),
                ),

                //show only when viewing
                ///from address
                if(!isEdit)
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

                //show only when adding
                /// FROM ADDRESS ADD
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: CustomText(text: "Hvor skal du flytte fra?",isBold: true),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Adresse *",controller: fromAdd,enabled: isEdit,),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer *",controller: fromZip,enabled: isEdit,),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By *",controller: fromBy,enabled: isEdit,),
                  ),


                ///to address
                if(!isEdit)
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

                /// TO ADDRESS ADD
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: CustomText(text: "Hvor skal du flytte til?",isBold: true),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Adresse *",controller: toAdd,enabled: isEdit,),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "Postnummer *",controller: toZip,enabled: isEdit,),
                  ),
                if(isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: LabelInputField(text: "By *",controller: toBy,enabled: isEdit,),
                  ),

                ///flexible
                isEdit?
                  ChipField(
                    isAdd: isEdit,
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
                    initialItem: flexible.text,
                    onChanged: (value) => flexible.text = value,
                  ):
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: LabelInputField(text: "Er flyttedagen fleksibel?",controller: flexible,),
                  ),


                ///isPacking
                ChipField(
                    isAdd: isEdit,
                    text: 'Skal flyttefirmaet stå for nedpakning af dine ting?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    initialItem: !widget.isAdd ? (isPacking?"Ja":"Nej") : null,
                    onChanged: (value)=> isPacking = value == 'Ja',
                  ),

                ///isCleaning
                ChipField(
                    isAdd: isEdit,
                    text: 'Vil du have flytterengøring i din nuværende bolig?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    initialItem: !widget.isAdd ? (isCleaning?"Ja":"Nej") : null,
                    onChanged: (value)=>isCleaning = value == 'Ja',
                  ),

                ///isHeavy
                ChipField(
                    isAdd: isEdit,
                    text: 'Skal der flyttes særligt tungt inventar?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    initialItem: !widget.isAdd ? (isHeavy?"Ja":"Nej") : null,
                    onChanged: (value)=>isHeavy = value == 'Ja',
                  ),

                ///heavy count
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: heavyCount,enabled: isEdit,keyBoardType: TextInputType.number,),
                ),

                ///isBreakable
                ChipField(
                    isAdd: isEdit,
                    text: 'Skal der flyttes inventar som nemt kan gå i stykker?',
                    items: [
                      'Ja',
                      'Nej'
                    ],
                    initialItem: !widget.isAdd ? (isBreakable?"Ja":"Nej") : null,
                    onChanged: (value)=>isBreakable = value == 'Ja',
                  ),

                ///break count
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Hvis ja, hvor meget?",controller: breakCount,enabled: isEdit,keyBoardType: TextInputType.number,),
                ),

                ///others
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Andre bemærkninger", maxLines: null,controller: others,enabled: isEdit,),
                ),

                /// approve and decline
                if (!widget.isAdd && widget.request!.status == Filter.Pending && !isEdit)
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

                ///change driver
                if (!widget.isAdd && widget.request!.status == Filter.Approved && !widget.isCompleted && userController.loggedInUserType != UserType.Driver && !isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: SizedBox(
                        width: double.infinity,
                        child: Button(
                            color: kApproved,
                            text: "Change Driver",
                            onPressed: ()=>showDialog(
                                context: context,
                                builder: (BuildContext context) => AssignDriver(requestID: widget.request!.id, assignedDriverID: widget.request!.driver)
                            )
                        )
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
                            onPressed: () => addEditTask(isEdit: false)
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
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => DriverCompletion(isAdd: true,taskID: widget.request!.id)));
                            }
                        )
                    ),
                  ),

                ///completed details
                if (widget.isCompleted && !isEdit)
                  Padding(
                    padding: EdgeInsets.only(top: 45.h),
                    child: SizedBox(
                        width: double.infinity,
                        child: Button(
                            color: kApproved,
                            text: "Completed Details",
                            onPressed: () async {
                              ToastBar(text: 'Fetching data', color: Colors.orange).show();
                              var driverController = Provider.of<DriverController>(context, listen: false);
                              CompleteTask task = await driverController.getCompletedTask(widget.request!.id);

                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => DriverCompletion(
                                  isAdd: false,
                                  taskID: widget.request!.id,
                                  completeTask: task,
                              )));
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

  addEditTask({required bool isEdit}){
    bool isValidated = firstName.text.isNotEmpty && lastName.text.isNotEmpty && telephone.text.isNotEmpty && email.text.isNotEmpty &&
        date.text.isNotEmpty && fromAdd.text.isNotEmpty && fromZip.text.isNotEmpty && fromBy.text.isNotEmpty &&
        toAdd.text.isNotEmpty && toZip.text.isNotEmpty && toBy.text.isNotEmpty;

    if (isValidated){
      RequestModel newRequest = RequestModel(
          id: widget.request?.id ?? "",
          firstName: firstName.text,
          lastName: lastName.text,
          telePhone: telephone.text,
          email: email.text,
          type: type,
          packageType: packageType,
          date: date.text.toLowerCase(),
          fromAddress: AddressModel(fromAdd.text, fromZip.text, fromBy.text),
          toAddress: AddressModel(toAdd.text, toZip.text, toBy.text),
          flexible: flexible.text,
          isPacking: isPacking,
          isCleaning: isCleaning,
          isHeavy: isHeavy,
          heavyCount: heavyCount.text,
          isBreakable: isBreakable,
          breakCount: breakCount.text,
          others: others.text,
          status: Filter.Pending
      );

      var controller = Provider.of<DriverAssignController>(context, listen: false);
      if (isEdit){
        controller.editRequest(newRequest, context);
      }
      else{
        controller.addRequest(newRequest, context);
      }
    }
    else {
      ToastBar(text: "Please fill required fields!", color: Colors.red).show();
    }
  }

}