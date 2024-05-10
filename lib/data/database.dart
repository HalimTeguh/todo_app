import 'package:hive/hive.dart';

class TodoDatabase{

  List todoList = [];
  // reference the database (Hive box)
  final myBox = Hive.box("myBox");

  // run this method when this app was 1st time ever opening this app
  void createInitialData(){
    todoList = [
      ['Hello There, add your task!', false ],
    ];
  }

  // load the data from database
  void loadData(){
    todoList = myBox.get("TODOLIST");
  }

  // Update the database
  void updateDatabase(){
    myBox.put("TODOLIST", todoList);
  }

}