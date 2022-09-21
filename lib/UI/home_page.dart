import 'dart:async';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app2022/UI/add_pill_bar.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/UI/widgets/pill_title.dart';
import 'package:medicine_reminder_app2022/controller/pill_controller.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';
import 'package:medicine_reminder_app2022/services/notification_services.dart';
import 'package:medicine_reminder_app2022/services/theme_services.dart';
import 'package:get/get.dart';

import 'widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _pillController = Get.put(PillController());


  late final notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _pillController.getPills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _appPillBar(),
          _appDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showsPills(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions:  const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/personal.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _appDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });

        },
      ),
    );
  }

  _appPillBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  //
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
            label: "+ Add Pill",
            onTap: () async {
              await Get.to(() => AddPillPage());
              _pillController.getPills();
            },
          ),
        ],
      ),
    );
  }

  _showsPills() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _pillController.pillList.length,
          itemBuilder: (_, index) {
            PillModel pill = _pillController.pillList[index];
            print(pill.toJson());
            _scheduleNotificationDate(pill);
            DateTime date = DateFormat.jm().parse(pill.startTime!);
            var myTime =DateFormat("HH:mm").format(date);

            if(pill.repeat=='Daily' && pill.remind==2) {
              notifyHelper.scheduledNotification(

                  int.parse(myTime.split(":")[0]),
                  int.parse(myTime.split(":")[1])+2,
                  pill

              );
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context, pill);

                          },
                          child: PillTitle(pill: pill),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            else if(pill.date==DateFormat.yMd().format(_selectedDate))
            {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context, pill);
                          },
                          child: PillTitle(pill: pill),
                        )
                      ],
                    ),
                  ),
                ),
              );

            }else  {
              return Container();
            }
          },
        );
      }),
    );
  }

  void _scheduleNotificationDate(PillModel pill){
    DateTime date = DateFormat.jm().parse(pill.startTime!);
    var myTime =DateFormat("HH:mm").format(date);
    notifyHelper.scheduledNotification(
        int.parse(myTime.toString().split(":")[0]),
        int.parse(myTime.toString().split(":")[1]),
        pill
    );
  }

  _showBottomSheet(BuildContext context, PillModel pill) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: pill.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          const Spacer(),
          pill.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  context:context,
                  label: "Pill Completed",
                  clr: primaryClr,
                  onTap: () {
                    _pillController.markPillCompleted(pill.id!);
                    Get.back();
                  }),
          _bottomSheetButton(
              context:context,
              label: "Delete Pill",
              clr: Colors.red[300]!,
              onTap: () {
                _pillController.delete(pill);
                //get refresh
                _pillController.getPills();
                Get.back();
              }),
          const SizedBox(height: 20,),
          _bottomSheetButton(
              context:context,
              label: "Close",
              clr: Colors.red[300]!,
              isClose: true,
              onTap: () {
                Get.back();
              }),
          const SizedBox(height: 10,),
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          color: isClose ==true ? Colors.transparent:clr,
          border: Border.all(
            width: 2,
            color: isClose ==true ? Get.isDarkMode ? Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


