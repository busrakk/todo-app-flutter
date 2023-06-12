import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_controller.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:flutter_application_1/shared/custom_text_form_field.dart';
import 'package:get/get.dart';

class EditScreen extends StatefulWidget {
  final Todo? todo;

  const EditScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // kullanıcıların gireceği alan
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();

  final TodoController todoController = Get.find();

  // açılan ekranda kayıt güncellenecek mi yoksa eklenecek mi??
  @override
  void initState() {
    // edit screen açıldığında burası ilk tetiklenecek yer
    if (widget.todo != null) {
      // todo içindeki değerleri textfield aktar
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      timeController.text = widget.todo!.time;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.todo != null ? "Update Todo" : "Add Todo"),
      ),
      body: Column(
        children: [
          CustomFormField(
              editingController: titleController,
              placeHolder: "Title",
              validationText: "title must have a valid value"),
          CustomFormField(
              editingController: descriptionController,
              placeHolder: "Description",
              validationText: "description must have a valid value"),
          CustomFormField(
              editingController: timeController,
              placeHolder: "Time",
              validationText: "time must have a valid value"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Todo todo1 = Todo(
                    id: 1,
                    title: titleController.text,
                    description: descriptionController.text,
                    time: timeController.text,
                    favorite: 1,
                    completed: 1);
                if (widget.todo != null) {
                  // güncelleme
                  todoController.updateTodo(widget.todo!.id, todo1);
                } else {
                  // ekleme
                  todoController.insertTodo(todo1);
                }
                Get.back();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              textColor: Colors.white,
              color: Colors.red,
              minWidth: double.infinity,
              child: Text(widget.todo != null ? "Update" : "Add"),
            ),
          )
        ],
      ),
    );
  }
}
