
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TitleAndMessage extends StatelessWidget {
  const TitleAndMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
           height: 100,
         child:  Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              "Be in control of your meds",
             style:  TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color:  Get.isDarkMode ?Colors.white :Colors.black
             ),
              maxLines: 2,
              textAlign: TextAlign.center,
           ),
           ),
         ),
        Container(
          height: 100,
              child:  Padding(
            padding:  const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              "An easy-to-use and reliable app that helps you remember to take your meds at the right time",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:  Get.isDarkMode ?Colors.white :Colors.black
              ),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}


