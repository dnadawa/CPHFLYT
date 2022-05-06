import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cphflyt/widgets/custom_text.dart';

class DrawerTile extends StatelessWidget {
  final String location;
  final String name;
  final Widget destination;
  final IconData iconData;

  const DrawerTile({required this.location,required this.name,required this.destination,required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: location == name ? Theme.of(context).primaryColor:null,),
      title: CustomText(text: name, isBold: true, color: location == name ? Theme.of(context).primaryColor:Colors.black,),
      onTap: (){
        if (location == name){
          Navigator.pop(context);
        }
        else{
          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
              destination), (Route<dynamic> route) => false);
        }
      },
    );
  }
}
