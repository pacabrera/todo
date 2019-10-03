import 'package:flutter/material.dart';

import 'todo.dart';


class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            final todo = new Todo(
                title: controller.value.text,
                description: controller.value.text);
            controller.clear();

            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}

class AddPage extends StatelessWidget {
  final controller = new TextEditingController();
  final controller2 = new TextEditingController();
final Color primary = Color(0xff3A4255);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To Do'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    // Tell your textfield which controller it owns
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: controller2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Description",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return FlatButton(
                      color: primary,
                      child: Text('Add', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        final todo = new Todo(
                            title: controller.value.text,
                            description: controller2.value.text);
                        controller.clear();

                        Navigator.of(context).pop(todo);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

