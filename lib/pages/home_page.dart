import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/components/dialog_box.dart';

import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text Controller
  final taskController = TextEditingController();

  //initialization data
  List todoList = [
    ['Make Todo', false],
  ];

  // Checkbox was clicked
  void changeChekbox(bool value, int index) {
    setState(() {
      todoList[index][1] = !value;
    });
  }

  // Save new Task
  void saveNewTask(String value){
    setState(() {
      todoList.add([value, false]);
      taskController.clear();
    });
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
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              title: todoList[index][0],
              isChecked: todoList[index][1],
              onchange: (value) => changeChekbox(todoList[index][1], index));
        },
      ),
    );
  }
}
