import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/models/user.dart';

import '../controllers/TodoController.dart';
import '../models/todo.dart';

class TodoAddScreen extends GetWidget<TodoController> {
  Todo? item;
  TodoAddScreen({super.key, this.item});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    if (item != null) {
      isEdit = true;
      titleController.text = item.title!;
      descriptionController.text = item.description!;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEdit ? 'Todo Edit' : 'Todo Add'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => isEdit ? updateData(context) : submitData(context),
                child: Text(isEdit ? 'Update' : 'Submit'))
            ],
          )
        )
      )
    );
  }

  void submitData(context) {
    final title = titleController.text;
    final description = descriptionController.text;
    titleController.text = '';
    descriptionController.text = '';
    final body = {
      "title": title,
      "description": description,
      "is_completed": true
    };
    controller.addTodo(body, context);
  }

  void updateData(context) {
    final id = item?.id;
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": item?.isCompleted
    };
    controller.updateTodo(id, body, context);
  }

}