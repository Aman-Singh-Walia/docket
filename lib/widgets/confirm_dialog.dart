import 'package:docket/data_manage/update_data.dart';
import 'package:flutter/material.dart';
import 'package:docket/model/task.dart';

showConfirmDialog(BuildContext context, Task task, String title, String message,
    String actmsg, Function action) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Varela',
            ),
          ),
          actions: [
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      action();
                      updateData(context);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      actmsg,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                      ),
                    ))
              ],
            )
          ],
        ); //alert dialog
      });
}
