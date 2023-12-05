import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../screens/books/data/models/collection_model.dart';

class BooksController extends GetxController {
  RxList<dynamic> dataList = [].obs;

  Future<void> loadData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/json/collections.json');
      final Map<String, dynamic> jsonData = json.decode(data);
      dataList.value = (jsonData['data'] as List)
          .map((item) => CollectionModel.fromJson(item))
          .toList();
    } catch (e) {
      print('Error loading data: $e');
    }
  }
}
