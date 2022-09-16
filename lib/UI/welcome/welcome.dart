
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app2022/UI/home_page.dart';
import 'package:medicine_reminder_app2022/UI/welcome/button.dart';
import 'package:medicine_reminder_app2022/UI/welcome/title_message.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
             Image.asset('assets/images/welcome_image.png',
                 width: double.infinity,height: 200,),
             const  SizedBox(height:  20,),
            const TitleAndMessage(),
            const  SizedBox(height:  20,),
          Container(
              child: const Padding(
                  padding:  EdgeInsets.only(left: 35.0, right: 35.0),
                  child:  Button(
                  )

              ),),
          ],
        ),
      ),
    );
  }
}

