import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
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
        child: Container(
          height: 400,
          width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getBGClr(pill?.color??0),
            ),
          child:  Row(
              children: [
                if(pill.image != null)Image.asset(pill.image!),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pill?.title??"",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        pill?.note??"",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: 0.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
              ]),
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
