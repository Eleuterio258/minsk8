import 'package:flutter/material.dart';
import 'package:minsk8/import.dart';

Widget buildModalBottomSheet(BuildContext context, {String description}) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
        ),
        Text('Точно хотите закрыть?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.8),
            )),
        SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlineButton(
              child: Text('Закрыть'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            SizedBox(
              width: 16,
            ),
            FlatButton(
              child: Text('Остаться'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
      ],
    ),
  );
}