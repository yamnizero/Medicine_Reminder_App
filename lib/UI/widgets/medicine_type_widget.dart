import 'package:flutter/material.dart';
import 'package:medicine_reminder_app2022/models/medicine_type.dart';

import '../theme.dart';

class MedicineTypeCard extends StatelessWidget {
  final MedicineType? pillType;
  final  Function? handler;
  MedicineTypeCard({ this.pillType,  this.handler});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handler!(pillType),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: pillType!.isChoose! ? bluishClr :Colors.white,
            ),
            width: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0,),
                 SizedBox(width:40,height: 40.0,child: pillType!.image),
                const SizedBox(height: 7.0,),
                Container(child: Text(pillType!.name!,style: TextStyle(
                    color:pillType!.isChoose! ? Colors.white : Colors.black,fontWeight: FontWeight.w500
                ),)),
              ],
            ),

          ),
        ),
        const SizedBox(width: 15.0,)
      ],
    );
  }
}