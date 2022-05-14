import 'package:docket/data_manage/update_data.dart';
import 'package:docket/model/task.dart';

import 'package:docket/pages/home_page.dart';
import 'package:docket/widgets/loading.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(context),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Loading();
          default:
            return Builder(builder: (context) {
              return const AppHome();
            });
        }
      },
    );
  }
}
