import 'package:flutter/material.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:docket/widgets/confirm_dialog.dart';

import 'package:provider/provider.dart';
import 'package:docket/model/task.dart';

class ItemExpired extends StatelessWidget {
  final Task task;
  const ItemExpired({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);

    void deleteExpired(BuildContext context) {
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
                            color: Colors.red),
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
              splashColor: Colors.red,
              onPressed: () {
                deleteExpired(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.grey[700],
              ))
        ],
      ),
    );
  }
}
