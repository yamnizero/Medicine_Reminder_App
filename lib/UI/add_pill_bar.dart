import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPillPage extends StatelessWidget {
  const AddPillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(),
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child:  Icon(
          Icons.arrow_back_ios,
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
