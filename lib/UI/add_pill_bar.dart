
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app2022/UI/theme.dart';
import 'package:medicine_reminder_app2022/UI/widgets/input_field.dart';

class AddPillPage extends StatefulWidget {
  const AddPillPage({Key? key}) : super(key: key);

  @override
  _AddPillPageState createState() => _AddPillPageState();
}

class _AddPillPageState extends State<AddPillPage> {

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  List<int> remindList =[
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList =[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
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
              const MyInputField(
                title: "Title",
                hint: "Enter your title",
              ),
              const MyInputField(
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
               MyInputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                 widget: DropdownButton(
                   icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                   iconSize: 32,
                   elevation: 4,
                   style:  subTitleStyle,
                   underline: Container(height: 0,),
                   items: repeatList.map<DropdownMenuItem<String>>((String? value ){
                     return DropdownMenuItem<String>(
                       value: value.toString(),
                       child: Text(value!,style: TextStyle(color: Colors.grey),),
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
              const SizedBox(height: 18,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",style: titleStyle,),
                      const SizedBox(height: 8.0,),
                      Wrap(
                        children: List<Widget>.generate(
                          3,
                            (int index){
                            return  Padding(
                              padding: const  EdgeInsets.only(right: 8.0),
                              child:  CircleAvatar(
                                radius: 14,
                                backgroundColor: index == 0 ? primaryClr : index== 1?pinkClr:yellowClr,
                              ),
                            );
                            }
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
