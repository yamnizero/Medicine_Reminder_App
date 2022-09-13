class PillModel{
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  String? medicineForm;

  PillModel({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.medicineForm

});
  PillModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
    medicineForm =json['medicineForm'];
  }

 Map<String,dynamic> toJson(){
    final  Map<String,dynamic> data =  <String,dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['medicineForm'] = medicineForm;
    return data;
 }
//---------------------| Get the medicine image path |-------------------------
  String get image{
    switch(medicineForm){
      case "Syrup": return "assets/images/syrup.png";
      case "Pill":return "assets/images/pills.png";
      case "Capsule":return "assets/images/capsule.png";
      case "Cream":return "assets/images/cream.png";
      case "Drops":return "assets/images/drops.png";
      case "Syringe":return "assets/images/syringe.png";
      default : return "assets/images/pills.png";
    }
  }

}