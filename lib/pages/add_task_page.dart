import 'package:date_field/date_field.dart';
import 'package:docket/data_manage/update_data.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:docket/services/notification_service.dart';
import 'package:docket/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController iconControl = TextEditingController();
    TextEditingController titleControl = TextEditingController();
    iconControl.text = '💙';

    DateTime defaultDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour + 2, DateTime.now().minute);

    DateTime defaultReminder = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour + 1,
        DateTime.now().minute);

    final provider = Provider.of<DocketProvider>(context);
    int notifyId =
        provider.allTasksList.isEmpty ? 0 : provider.allTasksList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (defaultReminder.isBefore(DateTime.now())) {
                  showAlertDialog(
                      context, 'Alert', 'Invalid reminder time', 'Okay');
                } else if (titleControl.text == '') {
                  showAlertDialog(
                      context, 'Alert', 'Empty task can not be saved', 'Okay');
                } else {
                  provider.addTask(
                      iconControl.text == '' ? '💙' : iconControl.text,
                      titleControl.text,
                      defaultDate.toString(),
                      defaultReminder.toString());

                  updateData(context);
                  NotificationService().showReminder(
                      notifyId,
                      'main_channel',
                      'Task',
                      '${iconControl.text} ${titleControl.text}',
                      defaultReminder.year,
                      defaultReminder.month,
                      defaultReminder.day,
                      defaultReminder.hour,
                      defaultReminder.minute);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(fontFamily: 'Varela', fontSize: 20.0),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
              child: Text(
                'Add Task',
                style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
            ),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: TextField(
                  controller: iconControl,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
                  ],
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  showCursor: false,
                  decoration: const InputDecoration(
                    counter: Offstage(),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 60.0,
                  ),
                ),
              ),
            ),
            Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(fontFamily: 'Varela'),
                        textCapitalization: TextCapitalization.sentences,
                        controller: titleControl,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 8,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Task',
                          labelStyle: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    //task date_________________________________________
                    DateTimeFormField(
                      initialDate: defaultDate,
                      initialValue: defaultDate,
                      firstDate: DateTime.now(),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.event_note,
                          color: Colors.blue,
                        ),
                        labelText: 'Date',
                      ),
                      mode: DateTimeFieldPickerMode.dateAndTime,
                      autovalidateMode: AutovalidateMode.always,
                      onDateSelected: (DateTime value) {
                        defaultDate = value;
                      },
                    ),
                    //divider________________________________________________________
                    const Divider(
                      color: Colors.blue,
                      thickness: 1.0,
                      height: 40.0,
                    ),
                    //reminder date time___________________________________________
                    DateTimeFormField(
                      initialDate: defaultReminder,
                      initialValue: defaultReminder,
                      firstDate: DateTime.now(),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.notification_add,
                          color: Colors.blue,
                        ),
                        labelText: 'Set Reminder',
                      ),
                      mode: DateTimeFieldPickerMode.dateAndTime,
                      autovalidateMode: AutovalidateMode.always,
                      onDateSelected: (DateTime value) {
                        defaultReminder = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ], //body column
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.blue,
      content: Text(
        'Task Added',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0, fontFamily: 'Varela', fontWeight: FontWeight.bold),
      ));
}
