import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';
//import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


///IOS
//ios>>Runner>>AppDelegate>>after return .. add
// if #available(iOS 10.0, *) {
//   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//     }

///Android
// android>>app>>src>>main>>res>>drawable...add image for ex: appicon.png

class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
            iOS: initializationSettingsIOS,
            android: initializationSettingsAndroid,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification
    );

  }

  scheduledNotification(int hour,int minutes,PillModel pill) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        pill.id!.toInt(),
        pill.title,
        pill.note,
        _convertTime(hour,minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        //change time
        matchDateTimeComponents: DateTimeComponents.time,

    );

  }

  tz.TZDateTime _convertTime(int hour,int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate  =
        tz.TZDateTime(tz.local,now.year,now.minute,now.day,hour,minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

//   static Future configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//
//     Logger.log('Timezone: $timeZoneName', className: '$AppConfig');
//     try {
//       tz.setLocalLocation(tz.getLocation(timeZoneName));
//     } catch () {
// // Failed to get timezone or device is GMT or UTC, assign generic timezone
//       const String fallback = 'Africa/Accra';
//       Logger.log('Could not get a legit timezone, setting as $fallback',
//           className: '$AppConfig');
//       tz.setLocalLocation(tz.getLocation(fallback));
//     }
//   }



  static Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();

    final String timezone =  await  FlutterNativeTimezone.getLocalTimezone();


    tz.setLocalLocation(tz.getLocation(timezone));
  }


  Future<void> displayNotification({required String title, required String body,}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const  AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription:"Your description",
        playSound: true,
        importance: Importance.max, priority: Priority.high);

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics =  NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }
  // Request Permissions for iOS
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(()=>Container(color: Colors.white,));
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    Get.dialog( const Text("Welcome to Flutter"));

  }
}