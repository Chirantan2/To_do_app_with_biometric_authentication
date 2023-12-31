import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/dialog_box.dart';
import 'package:to_do/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  
  
  //reference hive
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  
  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }
    else {
      db.loadData();
    }


    super.initState();
  }
  
  //text controller 
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add(
        [_controller.text, false]
      );
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDataBase();
  }

  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          Controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: createNewTask,
        child: const Icon(Icons.add)
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
      ),
    );
  }
}