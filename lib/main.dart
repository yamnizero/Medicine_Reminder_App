import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicine_reminder_app2022/UI/home_page.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/db/db_helper.dart';

import 'services/theme_services.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
   await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home:  const HomePage(),
    );
  }
}


