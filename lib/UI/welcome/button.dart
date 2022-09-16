

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../home_page.dart';

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  void goToHomeScreen() => Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (BuildContext context) => HomePage(),
  ));
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color:  Colors.amber,
            borderRadius: BorderRadius.circular(25)
        ),
        child:

            TextButton(
              onPressed:(){
                setState(() {
                  isLoading =true;
                });
                Future.delayed(Duration(seconds: 3),(){
                  setState(() {
                    goToHomeScreen();
                  });
                });
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white
              ),
              child:  isLoading? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                   Text("Loading...",style: TextStyle(fontSize: 20),),
                  SizedBox(width: 10,),
                  CircularProgressIndicator(),
                ],
              ) :Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Get started now",
                    style:   TextStyle(fontSize: 25,color:Get.isDarkMode ? Colors.white :Colors.black),
                  ),
                  Icon(

                      Icons.arrow_circle_right_outlined,size: 50,
                      color:  Get.isDarkMode ?Colors.white :Colors.black
                  )
                ],
              )
            ),
    );
  }
}


// class PlatformFlatButton extends StatelessWidget {
//
//   const PlatformFlatButton({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//           height: 60,
//           decoration: BoxDecoration(
//               color:  Colors.amber,
//             borderRadius: BorderRadius.circular(25)
//           ),
//           child:
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: goToHomeScreen,
//                 style: TextButton.styleFrom(
//                     foregroundColor: Colors.white
//                    ),
//                 child:  Text(
//                   "Get started now",
//                   style:   TextStyle(fontSize: 25,color:Get.isDarkMode ? Colors.white :Colors.black),
//                 ),
//               ),
//                Icon(
//
//                   Icons.arrow_circle_right_outlined,size: 50,
//                   color:  Get.isDarkMode ?Colors.white :Colors.black
//               )
//             ],
//           )
//
//         );
//
//
//   }
// }
