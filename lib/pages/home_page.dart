// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_notes.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the fist time opening this app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
    // rest of your code remains unchanged
  }



  // text controller
  final _controller = TextEditingController();


 // checkbox was tapped
 void checkBoxChanged(bool? value, int index){
   setState(() {
     db.toDoList[index] [1] = !db.toDoList[index] [1];
   });
   db.updateDataBase();
 }

 // save new tasks
  void saveNewTasks() {
   setState(() {
     db.toDoList.add([_controller.text, false]);
     _controller.clear();
   });
   Navigator.of(context).pop();
   db.updateDataBase();
  }

 // create a new task
 void createNewTask() {
   showDialog(
     context: context,
     builder: (context) {
       return DialogBox(
         controller: _controller,
         onSave: saveNewTasks,
         onCancel: () => Navigator.of(context).pop(),
       );
     },
   );
 }

 //delete task
  void deleteTask(int index) {
   setState(() {
     db.toDoList.removeAt(index);
   });
   db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[300],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[300],
          title: Text('Easy ToDo Notes',
            style: TextStyle( color: Colors.black, // Change the text color
            ),
          ),
          centerTitle: true, // Center the title text
        ),

    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.lightBlue[300],
      onPressed: createNewTask,
      child: Icon(Icons.add),
    ),


    body: ListView.builder(
      itemCount: db.toDoList.length,
      itemBuilder: (context, index) {
        return ToDoNotes(
        taskName: db.toDoList[index][0],
        taskCompleted: db.toDoList[index][1],
          onChanged: (value) =>  checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
    );
    }

    )
  );
  }
  }

