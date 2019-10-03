import 'package:flutter/material.dart';

import 'todo.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);

class TodoList extends StatelessWidget {
  TodoList({@required this.todos, this.onTodoToggle});

  final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(64, 75, 96, .9),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24),
                ),
              ),
              child: Checkbox(
                activeColor: Colors.red,
                value: todo.isDone,
                onChanged: (bool isChecked) {
                  onTodoToggle(todo, isChecked);
                },
              ),
              //Icon(Icons.check, color: Colors.white),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoView(todo: todos[index])),
                );
              },
              child: Text(
                todo.title,
                style: TextStyle(
                  color: todo.isDone ? Colors.black26 : Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoView(todo: todos[index])),
                );
              },
              child: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}

class TodoView extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;
  final Color primary = Color(0xff3A4255);
  // In the constructor, require a Todo.
  TodoView({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text("To Do List"),
        backgroundColor: primary,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 10.0),
              width: double.infinity,
              color: (todo.isDone) ? Colors.red : Colors.green,
              child: Center(
                child: (todo.isDone) ? Text('Status: Already Done', style: TextStyle(fontSize: 20.0, color: Colors.white, backgroundColor: Colors.red),)
                      : Text('Status: To Do', style: TextStyle(fontSize: 20.0, color: Colors.white, backgroundColor: Colors.green),),
              ),
            )
                  ,
            Text(
              todo.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.0),
            Text(
              todo.description,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
