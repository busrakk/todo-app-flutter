import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_controller.dart';
import 'package:flutter_application_1/shared/todo_item.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoController controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        // leading: , // sol taraf
        actions: [
          // sağ taraf
          IconButton(
              onPressed: () async {
                await controller.deleteTheDatabase();
              },
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.red,
              ))
        ],
      ),
      body: GetBuilder<TodoController>(
        builder: (controller) => controller.todoList.isEmpty
            ? const Center(
                child: Text(
                "Welcome to Todo App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ))
            : ListView.builder(
                itemCount: controller.todoList.length, // kaç tane item var
                itemBuilder: (context, index) => TodoItem(
                    todo: controller.todoList[index],
                    todoController: controller),
              ),
      ),
    );
  }
}
