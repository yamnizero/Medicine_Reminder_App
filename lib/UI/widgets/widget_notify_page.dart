import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class WidgetNotifyPage extends StatelessWidget {
  final String titleCard;
  final IconData iconCard;
  final String subTitleCard;
  const WidgetNotifyPage({Key? key, required this.titleCard, required this.iconCard, required this.subTitleCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0,),
        dense:true,
        leading:  Icon(iconCard,size: 45,),
        title: Text(titleCard,style:  const TextStyle(
          fontWeight: FontWeight.bold,
          //color: Get.isDarkMode ? Colors.black :Colors.white,
          fontSize: 28,

        ),),
        subtitle: Text(subTitleCard,style: const  TextStyle(
          fontWeight: FontWeight.bold,
          color:Colors.white,
          fontSize: 18,

        ),),
      ),
    );
  }


}
