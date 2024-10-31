import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/todo.dart';

class TodoController extends GetxController {
  RxBool isLoading = false.obs;
  var todoList = [].obs;

  getList() async {
    showLoading();
    final url = Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      print(result);
      todoList.value = result.map((e) => Todo.fromJson(e)).toList();
    } else {
      Get.snackbar('Error loading data!', 'Server responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
    hideLoading();
  }

  addTodo(data, context) async {
    showLoading();
    final url = Uri.parse("https://api.nstack.in/v1/todos");
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
          'Content-Type': 'application/json'
      }
    );
    print(response.body);
    if (response.statusCode == 201) {
      showSuccessMessage('Creation Success', context);
    } else {
      showErrorMessage('Creation Failed', context);
    }
    hideLoading();
  }

  updateTodo(id, data, context) async {
    print(data);
    showLoading();
    final url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    print(url);
    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {
          'Content-Type': 'application/json'
      }
    );
    print(response.body);
    if (response.statusCode == 200) {
      showSuccessMessage('Updated Success', context);
    } else {
      showErrorMessage('Updated Failed', context);
    }


    hideLoading();
  }

  deleteTodo(id, context) async {
    final url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      getList();
      showSuccessMessage('Delete Success', context);
    } else {
      showErrorMessage('Delete Failed', context);
    }
  }

  void showSuccessMessage(String message, context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message, context) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white)
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  validator(formKey) {
    return formKey.currentState!.validate();
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }
}