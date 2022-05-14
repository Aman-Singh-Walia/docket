import 'package:docket/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:docket/model/task.dart';

class DocketProvider extends ChangeNotifier {
  List<Task> allTasksList = [];

  List<Task> get todoTasksList => allTasksList
      .where((task) =>
          task.done == false &&
          DateTime.parse(task.date).isAfter(DateTime.now()))
      .toList();

  List<Task> get doneTasksList =>
      allTasksList.where((task) => task.done == true).toList();

  List<Task> get expiredTasksList => allTasksList
      .where((task) => DateTime.parse(task.date).isBefore(DateTime.now()))
      .toList();

  addTask(icon, title, date, reminder) {
    int _id = allTasksList.isEmpty ? 0 : allTasksList.length;
    allTasksList.add(Task(
        id: _id, icon: icon, title: title, date: date, reminder: reminder));
    notifyListeners();
  } //add

  deleteTask(Task task) {
    allTasksList.remove(task);
    NotificationService().cancelNotification(task.id);
    notifyListeners();
  } //delete

  deleteDoneTask(Task task) {
    allTasksList.remove(task);
    notifyListeners();
  } //delete

  markDone(Task task) {
    task.done = true;
    NotificationService().cancelNotification(task.id);
    notifyListeners();
  }

  unmarkDone(Task task) {
    task.done = false;
    notifyListeners();
  }

  editTask(Task task, id, icon, title, date, reminder) {
    id = task.id;
    task.icon = icon;
    task.title = title;
    task.date = date;
    task.reminder = reminder;
    notifyListeners();
  } //edit

}
