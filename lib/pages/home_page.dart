import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todoList = [
    ['Make Todo', false],
    ['Read Filosofi Teras', false],
    ['Eat', false],
  ];

  void changeChekbox(bool value, int index){
    setState(() {
      todoList[index][1] = !value;
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
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(title: todoList[index][0], isChecked: todoList[index][1], onchange: (value) => changeChekbox(todoList[index][1], index));
        },
      ),
    );
  }
}
