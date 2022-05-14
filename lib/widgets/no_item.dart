import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final String message;
  const NoItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message,
      style: TextStyle(
          fontFamily: 'Varela',
          color: Colors.grey[500],
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    ));
  }
}
