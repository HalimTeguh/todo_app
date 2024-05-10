import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/data/database.dart';

import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the local database (Hive)
  final myBox = Hive.box("myBox");
  TodoDatabase db = TodoDatabase();

  // Text Controller
  final taskController = TextEditingController();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if(myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  // Checkbox was clicked
  void changeChekbox(bool value, int index) {
    setState(() {
      db.todoList[index][1] = !value;
    });
    db.updateDatabase();
  }

  // Save new Task
  void saveNewTask(String value){
    setState(() {
      db.todoList.add([value, false]);
      taskController.clear();
    });
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  void cancelAddNewTask(){
    setState(() {
      taskController.clear();
    });
    Navigator.of(context).pop();
  }

  // create new Task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            taskController: taskController, 
            onSave: () => saveNewTask(taskController.text), 
            onCancel: () => cancelAddNewTask(),
          );
        });
  }

  // delete task
  void deleteFunction(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'Todo App',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              title: db.todoList[index][0],
              isChecked: db.todoList[index][1],
              onchange: (value) => changeChekbox(db.todoList[index][1], index), 
              deleteFunction: (context) => deleteFunction(index),);
        },
      ),
    );
  }
}
