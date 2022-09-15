


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/UI/widgets/button.dart';
import 'package:medicine_reminder_app2022/UI/widgets/input_field.dart';
import 'package:medicine_reminder_app2022/UI/widgets/medicine_type_widget.dart';
import 'package:medicine_reminder_app2022/controller/pill_controller.dart';
import 'package:medicine_reminder_app2022/models/medicine_type.dart';
import 'package:medicine_reminder_app2022/models/pill_model.dart';
import 'package:medicine_reminder_app2022/utils/constants.dart';

class AddPillPage extends StatefulWidget {
  const AddPillPage({Key? key}) : super(key: key);

  @override
  _AddPillPageState createState() => _AddPillPageState();
}

class _AddPillPageState extends State<AddPillPage> {

  final PillController _pillController = Get.put(PillController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  List<int> remindList =[
    5,
    10,
    15,
    20,
  ];

  //list of medicines forms objects
  final List<MedicineType> medicineTypes = [
    MedicineType("Syrup", Image.asset(kSyrupImage), true,kSyrupImage),
    MedicineType(
        "Pill", Image.asset(kPillImage), false,kPillImage),
    MedicineType(
        "Capsule", Image.asset(kCapsuleImage), false,kCapsuleImage),
    MedicineType(
        "Cream", Image.asset(kCreamImage), false,kCreamImage),
    MedicineType(
        "Drops", Image.asset("assets/images/drops.png"), false,"assets/images/drops.png"),
    MedicineType(
        "Syringe", Image.asset("assets/images/syringe.png"), false,"assets/images/syringe.png"),
  ];
  String _selectedRepeat = "None";
  List<String> repeatList =[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selectedColor = 0;
  int _selectedTypeImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Pill",
              style: headingStyle,
              ),
               MyInputField(
                controller: _titleController,
                title: "Title",
                hint: "Enter your title",
              ),
               MyInputField(
                 controller: _noteController,
                title: "Note",
                hint: "Enter your note",
              ),
               MyInputField(
                 widget: IconButton(
                   icon: const Icon(Icons.calendar_today_outlined,
                   color: Colors.grey,
                   ),
                   onPressed: (){
                     _getDateFromUser();
                   },
                 ),
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),

              ),
              Row(
                children:  [
                  Expanded(
                    child:MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded,color: Colors.grey,),
                        onPressed: (){
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child:MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded,color: Colors.grey,),
                        onPressed: (){
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
               MyInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                 widget: DropdownButton(
                   icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                   iconSize: 32,
                   elevation: 4,
                   style:  subTitleStyle,
                   underline: Container(height: 0,),
                   items: remindList.map<DropdownMenuItem<String>>((int value ){
                     return DropdownMenuItem<String>(
                       value: value.toString(),
                       child: Text(value.toString()),
                     );
                   }
                   ).toList(),
                   onChanged: (String? newValue) {
                     setState(() {
                       _selectedRemind = int.parse(newValue!);
                     });
                   },
                 ),
              ),

              //IMages

               MyInputField(
                title: "Repeat",
                hint: _selectedRepeat,
                 widget: DropdownButton(
                   icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                   iconSize: 32,
                   elevation: 4,
                   style:  subTitleStyle,
                   underline: Container(height: 0,),
                   items: repeatList.map<DropdownMenuItem<String>>((String? value ){
                     return DropdownMenuItem<String>(
                       value: value.toString(),
                       child: Text(value!,style: const TextStyle(color: Colors.grey),),
                     );
                   }
                   ).toList(),
                   onChanged: (String? newValue) {
                     setState(() {
                       _selectedRepeat = newValue!;
                     });
                   },
                 ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 16,bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Medicine form",style: titleStyle,),
                    const SizedBox(height: 8.0,),
                    Container(
                      height: 80,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ...medicineTypes.map(
                                  (type) => MedicineTypeCard(pillType: type,handler: medicineTypeClick,))
                        ],
                      ),
                    ),
                  ],
                ),
              ),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(label: "Create Pill", onTap: ()=>_validateDate())
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
     _addPillToDb();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Required","All fields are required !",
      snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,)
      );
    }
  }

  _addPillToDb()async {
   int value  = await _pillController.addPill(
      pill: PillModel(
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        // medicineForm: _selectedTypeImage,
        image: medicineTypes.firstWhere((element) => element?.isChoose ?? false,orElse: ()=> medicineTypes.first).rawImage,

        isCompleted: 0,
      )
    );
   print("My id is " "$value");

  }

  void medicineTypeClick(MedicineType medicine) {
    setState(() {
      medicineTypes.forEach((element) {element.isChoose = false;});
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }
  _typeImagePalette(){
    return

        // Text("Medicine form",style: titleStyle,),
        // const SizedBox(height: 8.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Medicine form",style: titleStyle,),
            const SizedBox(height: 8.0,),

            Wrap(
                children: List<Widget>.generate(
                    6,
                        (int index){
                      return  GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedTypeImage =index;

                          });
                        },
                        child: Padding(
                          padding: const  EdgeInsets.only(right: 8.0),
                          child:  CircleAvatar(
                            radius: 100.0,
                          child: _selectedTypeImage==index
                              ? const Icon(Icons.done,color: Colors.white,size: 16,)
                              :Container(),
                        ),
                        ),
                      );

                    }
                )

            ),
          ],
        );

  }

  _colorPalette(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: titleStyle,),
        const SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return  GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor =index;

                    });
                  },
                  child: Padding(
                    padding: const  EdgeInsets.only(right: 8.0),
                    child:  CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0 ? primaryClr : index== 1?pinkClr:yellowClr,
                      child: _selectedColor==index
                          ? const Icon(Icons.done,color: Colors.white,size: 16,)
                          :Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
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
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
    );
    if(_pickerDate !=null){
      setState(() {
        _selectedDate = _pickerDate;
      });

    }else{
      print("it's null or something is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime  =  pickedTime.format(context);
    if(pickedTime==null){
      print("Time canceld");
    }else if(isStartTime==true){
      setState(() {
        _startTime = _formatedTime;
      });
    }else if(isStartTime==false){
     setState(() {
       _endTime = _formatedTime;
     });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
       ),
    );
  }


}
