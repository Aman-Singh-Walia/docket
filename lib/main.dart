import 'package:docket/provider/docket_provider.dart';
import 'package:docket/services/notification_service.dart';
import 'package:docket/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  NotificationService().initAwesomeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DocketProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
