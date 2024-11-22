// enum TaskStatue { pending, completed }

class TasksModel {
  int? id;
  String title;
  String description;
  String date;
  String status;

  TasksModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.status = 'pending',

  });

  factory TasksModel.formJson(Map<String, dynamic>json){
    return TasksModel(

        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],

    );
  }
toMap(){
    return{
        'title' : title,
        'description' : description,
        'date' : date,
        'status' : status,

    };
  }
}