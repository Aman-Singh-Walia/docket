import 'package:docket/provider/docket_provider.dart';

import 'package:docket/widgets/no_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:docket/widgets/item_done.dart';

class DoneList extends StatefulWidget {
  const DoneList({Key? key}) : super(key: key);

  @override
  _DoneListState createState() => _DoneListState();
}

class _DoneListState extends State<DoneList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);
    return provider.doneTasksList.isEmpty
        ? const NoItem(message: 'No Completed Tasks')
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
                  provider.doneTasksList.map((e) => ItemDone(task: e)).toList(),
            ),
          );
  }
}
