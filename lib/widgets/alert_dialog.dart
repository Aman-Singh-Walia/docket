import 'package:flutter/material.dart';

showAlertDialog(
    BuildContext context, String title, String message, String actmsg) {
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
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontFamily: 'Varela',
                ),
              ),
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
                    child: Text(
                      actmsg,
                      style: const TextStyle(
                          fontFamily: 'Varela', fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ); //alert dialog
      });
}
