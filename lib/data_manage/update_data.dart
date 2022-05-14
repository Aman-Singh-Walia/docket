import 'package:docket/model/task.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void updateData(BuildContext context) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final provider = Provider.of<DocketProvider>(context, listen: false);
  List<String> savedData =
      provider.allTasksList.map((e) => jsonEncode(e.toMap())).toList();
  sharedPreferences.setStringList('savedData', savedData);
}

// loadData() async {
//   sharedPreferences = await SharedPreferences.getInstance();
//   List<String>? savedData = sharedPreferences.getStringList('savedData');
//   List<Task> loadedData = savedData == null
//       ? []
//       : savedData.map((e) => Task.fromMap(jsonDecode(e))).toList();
//   return loadedList = loadedData;
// } //loadData

Future<List<Task>> fetchData(BuildContext context) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final provider = Provider.of<DocketProvider>(context, listen: false);
  List<String>? savedData = sharedPreferences.getStringList('savedData');
  List<Task> loadedData = savedData == null
      ? []
      : savedData.map((e) => Task.fromMap(jsonDecode(e))).toList();

  return provider.allTasksList = loadedData;
}
