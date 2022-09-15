import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/UI/widgets/widget_notify_page.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';


class NotifiedPage extends StatelessWidget {
  final String? label;
  final PillModel pill;

  const NotifiedPage({Key? key,required this.pill,required this.label,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.grey[600]:Colors.white,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon:  Icon(Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white:Colors.grey,
          ),
        ),
        centerTitle: true,
        title: Text(pill?.title ?? 'No title',style: const TextStyle(
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: const [
                    Text("Hello,Medicine",style:  TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    Text("You have a new reminder",style:  TextStyle(fontSize: 14,color: Colors.grey),),

                  ],
                )),
            const SizedBox(height: 20,),
            Container(
              height: 400,
              width: 300,
              margin: const EdgeInsets.only(bottom: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _getBGClr(pill?.color??0),
                ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if(pill.image != null)Container(
                  //     height: 100,
                  //     width: 50,
                  //     child: Image.asset(pill.image!)),
                  WidgetNotifyPage(
                    iconCard:Icons.title,
                    titleCard: "Title",
                    subTitleCard: pill.title??"",
                  ),
                  WidgetNotifyPage(
                    iconCard:Icons.description,
                    titleCard: "Description",
                    subTitleCard: pill.note??"",
                  ),
                  WidgetNotifyPage(
                    iconCard:Icons.calendar_today ,
                    titleCard: "Date",
                    subTitleCard: pill.startTime??"",
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
