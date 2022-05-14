import 'package:docket/animations/page_transition.dart';
import 'package:docket/data_manage/update_data.dart';
import 'package:docket/model/task.dart';
import 'package:docket/pages/edit_task_page.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:docket/widgets/alert_dialog.dart';
import 'package:docket/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ItemTask extends StatelessWidget {
  final Task task;
  const ItemTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);

    void delete(BuildContext context) {
      showConfirmDialog(context, task, 'Delete',
          'Do you want to delete this task ?', 'Delete', () {
        provider.deleteTask(task);
      });
    } //delete

    return Card(
      shadowColor: Colors.blue[100],
      clipBehavior: Clip.hardEdge,
      elevation: 3.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: InkWell(
        onLongPress: () {
          showAlertDialog(context, "Task", task.title, 'Close');
        },
        child: Slidable(
          startActionPane: ActionPane(
              extentRatio: 0.35,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: delete,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                ),
                SlidableAction(
                    onPressed: editTaskPage,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    icon: Icons.mode_edit)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        task.icon,
                        style: const TextStyle(fontSize: 35.0),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            task.title,
                            style: const TextStyle(
                                fontFamily: 'Varela', fontSize: 18.0),
                            softWrap: true,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  splashColor: Colors.green,
                  onPressed: () {
                    provider.markDone(task);
                    updateData(context);
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void editTaskPage(BuildContext context) =>
      Navigator.of(context).push(CustomPageRoute(
          child: EditTaskPage(
        task: task,
      )));
}
