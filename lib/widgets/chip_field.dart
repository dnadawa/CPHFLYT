import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ChipField extends StatelessWidget {
  final String text;
  final List<String?>? initialValue;
  final List<MultiSelectItem> items;
  final double? fontSize;

  const ChipField({required this.text,required this.initialValue,required this.items, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: AbsorbPointer(
        absorbing: true,
        child: MultiSelectChipField(
          searchable: false,
          title: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: fontSize??16.sp),),
          chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,side: BorderSide(color: Theme.of(context).primaryColor)),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor,width: 3),
              borderRadius: BorderRadius.circular(8.r)
          ),
          selectedChipColor: Theme.of(context).primaryColor,
          selectedTextStyle: TextStyle(color: Colors.white),
          scroll: false,
          initialValue: initialValue,
          items: items,
        ),
      ),
    );
  }
}
