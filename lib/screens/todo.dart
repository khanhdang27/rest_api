import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/models/user.dart';
import 'package:rest_api/screens/todo_add.dart';

import '../controllers/TodoController.dart';

class TodoListScreen extends GetWidget<TodoController> {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getList();

    List todoList = controller.todoList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Todo List'),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  textStyle: TextStyle(fontSize: 17),
                  backgroundColor: const Color.fromRGBO(213, 213, 213, 1.0)
                ),
                child: const Text('Add', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  await Get.to(()=>TodoAddScreen());
                  controller.getList();
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getList(),
          child: Column(
            children: [
              Expanded(child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }
                // if(controller.todoList.isEmpty){
                //   return const Padding(
                //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                //     child: Center(
                //       child: Text(
                //         "Khong co data",
                //         style: TextStyle(fontSize: 30)
                //       ),
                //     ),
                //   );
                // }
                return Visibility(
                  visible: controller.todoList.isNotEmpty,
                  replacement: const Center(
                    child: Text(
                        "Khong co data",
                        style: TextStyle(fontSize: 30)
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (_, index) {
                      final todo = todoList[index];
                      final id = todo.id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Card(
                          color: Colors.yellow,
                          child: ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(
                              '${todoList[index].title}', style: const TextStyle(color: Colors.red),
                            ),
                            subtitle: Text(
                              '${todoList[index].description}', style: const TextStyle(color: Colors.pink),
                            ),
                            trailing: PopupMenuButton(
                              onSelected: (value) async {
                                if (value == 'edit') {
                                  await Get.to(() => TodoAddScreen(item: todo));
                                  controller.getList();
                                } else if (value == 'delete') {
                                  controller.deleteTodo(id, context);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              }
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }))
            ],
          )
        )
      )
    );
  }

  void navigateToAddPage() {

  }
}