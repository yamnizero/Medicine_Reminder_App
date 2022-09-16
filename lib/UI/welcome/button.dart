

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PlatformFlatButton extends StatelessWidget {
    final void Function() onPressed;
    final String text;
  const PlatformFlatButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: 60,
          decoration: BoxDecoration(
              color:  Colors.amber,
            borderRadius: BorderRadius.circular(25)
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white
                   ),
                child:  Text(
                  text,

                  style:   TextStyle(fontSize: 25,color:Get.isDarkMode ? Colors.white :Colors.black),
                ),
              ),
               Icon(
                  Icons.arrow_circle_right_outlined,size: 50,
                  color:  Get.isDarkMode ?Colors.white :Colors.black
              )
            ],
          )

        );


  }
}
