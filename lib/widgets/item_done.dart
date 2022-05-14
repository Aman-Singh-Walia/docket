import 'package:docket/data_manage/update_data.dart';
import 'package:docket/model/task.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:docket/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ItemDone extends StatelessWidget {
  final Task task;
  const ItemDone({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);

    void deleteDone(BuildContext context) {
      showConfirmDialog(context, task, 'Delete',
          'Do you want to delete this task ?', 'Delete', () {
        provider.deleteDoneTask(task);
      });
    } //delete

    return Card(
      shadowColor: Colors.blue[100],
      clipBehavior: Clip.hardEdge,
      elevation: 3.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.20,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteDone,
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
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
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          task.title,
                          style: const TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 18.0,
                              decoration: TextDecoration.lineThrough),
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
                splashColor: Colors.blue,
                onPressed: () {
                  provider.unmarkDone(task);
                  updateData(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.blue,
                ))
          ],
        ),
      ),
    );
  }
}
