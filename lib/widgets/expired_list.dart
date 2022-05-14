import 'package:docket/provider/docket_provider.dart';
import 'package:docket/widgets/item_expired.dart';

import 'package:docket/widgets/no_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpiredList extends StatefulWidget {
  const ExpiredList({Key? key}) : super(key: key);

  @override
  _ExpiredListState createState() => _ExpiredListState();
}

class _ExpiredListState extends State<ExpiredList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocketProvider>(context);

    return provider.expiredTasksList.isEmpty
        ? const NoItem(message: 'No Expired task')
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: provider.expiredTasksList
                  .map((e) => ItemExpired(task: e))
                  .toList(),
            ),
          );
  }
}
