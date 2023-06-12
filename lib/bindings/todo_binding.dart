
import 'package:flutter_application_1/controller/todo_controller.dart';
import 'package:get/get.dart';

class TodoBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}