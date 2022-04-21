import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddChipField extends StatefulWidget {
  final String text;
  final List<String> items;
  final Function onChanged;

  const AddChipField({required this.text, required this.items,required this.onChanged});

  @override
  _AddChipFieldState createState() => _AddChipFieldState();
}

class _AddChipFieldState extends State<AddChipField> {
  List<Widget> items = [];
  String? selectedElement;

  buildItems(){
    items.clear();

    for (var element in widget.items) {
      items.add(
          GestureDetector(
        onTap: (){
          selectedElement = element;
          buildItems();
          widget.onChanged(element);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff1470AF), width: 2),
            color: selectedElement==element?Color(0xff1470AF):Colors.white,
          ),
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
            child: Text(
              element,
              style: TextStyle(
                color: selectedElement==element?Colors.white:Colors.black,
              ),
            ),
          ),
        ),
      )
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    selectedElement = widget.items[0];
    buildItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              color: Color(0xff1470AF),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white),
              ),
            ),
            width: double.infinity,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
            border: Border.all(color: Color(0xff5B9AC6), width: 4),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Wrap(
              children: items,
            ),
          ),
        ),
      ],
    );
  }
}
