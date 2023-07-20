import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

  List toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["You can slide to delete", false],
      ["Complete DBMS Pracs", false],
      ["Seminar PPT and project", false],
      ["100 Pushups", true],
    ];
  }

  //load data from databasse
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //udpate the database 
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}