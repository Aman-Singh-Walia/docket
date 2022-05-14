import 'package:date_field/date_field.dart';
import 'package:docket/data_manage/update_data.dart';
import 'package:docket/model/task.dart';
import 'package:docket/provider/docket_provider.dart';
import 'package:docket/services/notification_service.dart';
import 'package:docket/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController iconControl = TextEditingController();
    TextEditingController titleControl = TextEditingController();

    DateTime defaultDate = DateTime.parse(widget.task.date);
    DateTime defaultReminder = DateTime.parse(widget.task.reminder);
    titleControl.text = widget.task.title;
    iconControl.text = widget.task.icon;

    final provider = Provider.of<DocketProvider>(context);
    int notifyId = widget.task.id;

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
                      context, 'Alert', 'Dont leave task empty', 'Ok');
                } else {
                  provider.editTask(
                      widget.task,
                      widget.task.id,
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
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Save Changes',
                style: TextStyle(fontSize: 20.0, fontFamily: 'Varela'),
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
                'Edit Task',
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
                        controller: titleControl,
                        textCapitalization: TextCapitalization.sentences,
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
}
