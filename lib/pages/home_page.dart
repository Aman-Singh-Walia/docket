import 'package:docket/animations/page_transition.dart';
import 'package:docket/pages/add_task_page.dart';
import 'package:docket/widgets/done_list.dart';
import 'package:docket/widgets/expired_list.dart';
import 'package:docket/widgets/task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Text(
            'Docket',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 25.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                onPressed: () {
                  addTaskPage(context);
                },
                icon: const Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.blue,
                )),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(
                fontFamily: 'Varela',
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            tabs: [Text('Tasks'), Text('Done'), Text('Expired')],
          ),
        ),
        body: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.fromLTRB(00, 20, 0.0, 0.0),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30.0))),
          child: const TabBarView(
            children: [TaskList(), DoneList(), ExpiredList()],
          ),
        ),
      ),
    );
  }

  void addTaskPage(BuildContext context) =>
      Navigator.of(context).push(CustomPageRoute(child: const AddTaskPage()));
}
