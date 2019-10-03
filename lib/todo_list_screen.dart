import 'package:flutter/material.dart';
import 'todo.dart';
import 'dart:core';
import 'new_todo_dialog.dart';
import 'todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return AddPage();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() => todos.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark as done?'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text("CANCEL")),
              new FlatButton(
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: new Text("Mark As Done"))
            ],
          );
        });
  }

  final Color primary = Color(0xff3A4255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: primary,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 30, left: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.0),
                    (todos.where((todos) => todos.isDone == false).length <= 0)
                        ? Text(
                            "Good Job! You don't have \nany remaining tasks to do!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          )
                        : Text(
                            "You have " +
                                todos
                                    .where((todos) => todos.isDone == false)
                                    .length
                                    .toString() +
                                " remaining\ntasks to do!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20.0),
              child: OverflowBox(
                maxWidth: 500,
                alignment: Alignment.centerLeft,
                child: Text(
                  "What to do?",
                  style: TextStyle(
                      color: primary,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            (todos.length <= 0)
                ? Center(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_dissatisfied, size: 300.0,color: Color(0xff9CA6A6),),
                      Text(
                        "Your list is empty",
                        style: TextStyle(
                            color: primary,
                            fontSize: 15.0,),
                      ),
                      Text(
                        "Add something to make me happy :)",
                        style: TextStyle(
                            color: primary,
                            fontSize: 12.0,),
                      ),
                    ],
                  ),
                )
                : TodoList(
                    todos: todos,
                    onTodoToggle: _toggleTodo,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }

}
