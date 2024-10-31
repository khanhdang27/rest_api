import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/country.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  var countryList = [].obs;

@override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    isLoading.value = true;
    final url = Uri.parse("https://restcountries.com/v3.1/all");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      countryList.value = result.map((e) => Country.fromJson(e)).toList();
    } else {
      Get.snackbar('Error loading data!', 'Server responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
    isLoading.value = false;
  }
}