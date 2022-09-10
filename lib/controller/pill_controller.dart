
import 'package:get/get.dart';
import 'package:medicine_reminder_app2022/db/db_helper.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';

class PillController extends GetxController{

  // get called during the initialization
  @override
  void onReady() {
    getPills();
    super.onReady();
  }

  var pillList= <PillModel>[].obs;

  Future<int> addPill({PillModel? pill }) async {
    return await DBHelper.insert(pill);
  }
  //get  all the data from table
  void getPills() async {
    List<Map<String,dynamic>> pills = await DBHelper.query();
    pillList.assignAll(pills.map((data) => PillModel.fromJson(data)).toList());
  }

  //responsible for deleting
  void delete(PillModel pill){
     DBHelper.deleteHelper(pill);

  }

}