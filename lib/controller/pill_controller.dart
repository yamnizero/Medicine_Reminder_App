
import 'package:get/get.dart';
import 'package:medicine_reminder_app2022/db/db_helper.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';

class PillController extends GetxController{

  // get called during the initialization
  @override
  void onReady() {

    super.onReady();
  }

  Future<int> addPill({PillModel? pill }) async {
    return await DBHelper.insert(pill);
  }

}