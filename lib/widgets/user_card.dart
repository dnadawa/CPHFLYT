import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:provider/provider.dart';
import 'package:cphflyt/widgets/custom_text.dart';

class UserCard extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final UserType type;
  final String id;

  const UserCard({required this.name,required this.email,required this.phone,required this.type,required this.id});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool edit = false;

  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
    phone.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    var userManagementController = Provider.of<UserManagementController>(context);

    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(edit ? Icons.check :Icons.edit, color: Theme.of(context).primaryColor,),
                onPressed: (){
                  setState(() {
                    edit = !edit;
                  });

                  if (!edit){
                    userManagementController.updateUser(name: name.text, phone: phone.text, id: widget.id, type: widget.type);
                  }
                },
              ),

              IconButton(
                icon: Icon(Icons.delete, color: kDeclined,),
                onPressed: () => showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                  content: CustomText(text: 'Are you sure you want to delete the user?'),
                  actions: [
                    TextButton(child: CustomText(text: 'Yes',),onPressed: (){
                      userManagementController.deleteUser(id: widget.id, type: widget.type);
                      Navigator.pop(context);
                    },),
                    TextButton(child: CustomText(text: 'No',),onPressed: ()=>Navigator.pop(context),),
                  ],
                )),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: LabelInputField(
              text: "Name",
              enabled: edit,
              controller: name,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 3.h, 15.w, 10.h),
            child: LabelInputField(
              text: "Email",
              enabled: false,
              controller: email,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 3.h, 15.w, 10.h),
            child: LabelInputField(
              text: "Phone",
              enabled: edit,
              controller: phone,
            ),
          ),
        ],
      ),
    );
  }
}
