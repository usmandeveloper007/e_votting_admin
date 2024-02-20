import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


timePicker(BuildContext context, Rxn<String> time) async {

  TimeOfDay? newSelectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            colorScheme: ColorScheme.light(primary: Colors.black,),
            buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      });

  if (newSelectedTime != null) {
    final now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day,
        newSelectedTime.hour, newSelectedTime.minute);
    time.value = DateFormat('HH:mm').format(dateTime);
  }
}