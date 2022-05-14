import 'package:docket/provider/docket_provider.dart';
import 'package:docket/widgets/item_task.dart';

import 'package:docket/widgets/no_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);
    return provider.todoTasksList.isEmpty
        ? const NoItem(message: 'No Tasks')
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: provider.todoTasksList
                  .map((e) => ItemTask(
                        task: e,
                      ))
                  .toList(),
            ),
          );
  }
}
