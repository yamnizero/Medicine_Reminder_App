import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app2022/UI/add_pill_bar.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/services/notification_services.dart';
import 'package:medicine_reminder_app2022/services/theme_services.dart';
import 'package:get/get.dart';

import 'widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage>  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children:  [
          _appPillBar(),
          _appDateBar()
        ],
      ),
    );
  }

  _appDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle:  const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        onDateChange: (date){
          _selectedDate = date;
        },
      ),
    );
  }
  _appPillBar(){
    return  Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",style: headingStyle,)
              ],
            ),
          ),
          MyButton(
            label: "+ Add Pill",
            onTap: ()=>Get.to(AddPillPage()),
          ),
        ],
      ),
    );
  }
  _appBar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0.0,
      leading: GestureDetector(
         onTap: (){
           ThemeService().switchTheme();
           notifyHelper.displayNotification(
             title:"Theme Changed",
             body:Get.isDarkMode?  "Activated Light Theme" : "Activated Dark Theme",
           );
           notifyHelper.scheduledNotification();
         },
        child:  Icon(
          Get.isDarkMode?
           Icons.wb_sunny_outlined
          :Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ?Colors.white:Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/personal.png"
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}
