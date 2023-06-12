import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_controller.dart';
import 'package:flutter_application_1/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoController todoController;
  final Todo todo;

  const TodoItem({Key? key, required this.todo, required this.todoController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(child: Text(todo.title)),
                  Expanded(child: Text(todo.time))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(todo.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        await todoController.deleteTodo(todo.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () {
                        // navigate to the edit screen with todo entity
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
