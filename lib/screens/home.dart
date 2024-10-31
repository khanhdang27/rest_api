import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api/screens/todo.dart';

import '../controllers/HomeController.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List countryList = controller.countryList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Restful API'),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  textStyle: TextStyle(fontSize: 17),
                  backgroundColor: const Color.fromRGBO(213, 213, 213, 1.0)
                ),
                child: const Text('Todo', style: TextStyle(color: Colors.red),),
                onPressed: () => Get.to(() => TodoListScreen()),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                        child: const CircularProgressIndicator(
                            semanticsLabel: 'Linear progress indicator'
                        )
                    ));
              }
              if(controller.countryList.isEmpty){
                return const Text("Khong co data");
              }
              return ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      color: Color.fromRGBO(213, 213, 213, 1.0),
                      child: ListTile(
                        title: Text(
                          '${countryList[index].name.common}', style: const TextStyle(color: Colors.red),
                        ),
                        subtitle: Text(
                          '${countryList[index].cca2}', style: const TextStyle(color: Colors.pink),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(countryList[index].flags.png),
                        ),
                      ),
                    ),
                  );
                },
              );
            }))
          ],
        ),
      )
    );
  }

}