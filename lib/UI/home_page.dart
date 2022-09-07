import 'package:flutter/material.dart';
import 'package:medicine_reminder_app2022/services/notification_services.dart';
import 'package:medicine_reminder_app2022/services/theme_services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage>  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
        children: const [
          Text("Theme Data",
          style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
  _appBar(){
    return AppBar(
      leading: GestureDetector(
         onTap: (){
           ThemeService().switchTheme();
           notifyHelper.displayNotification(
             title:"Theme Changed",
             body:Get.isDarkMode?  "Activated Light Theme" : "Activated Dark Theme",
           );
           notifyHelper.scheduledNotification();
         },
        child: const Icon(Icons.nightlight_round,size: 20,),
      ),
      actions: const [
        Icon(size: 20,Icons.person,),
        SizedBox(width: 20,)
      ],
    );
  }
}
