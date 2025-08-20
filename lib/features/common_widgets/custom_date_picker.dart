import 'package:flutter/material.dart';

import '../../config/theme.dart';


Future<DateTime?> pickDate(
    {required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate}) async {
  DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme(
                brightness: Theme.of(context).brightness,
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
                secondary: Colors.white,
                onSecondary: Colors.black,
                error: Colors.red,
                onError: Colors.white,
                // background: Theme.of(context).cardColor,
                // onBackground: Colors.white,
                surface: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black54,
                onSurface: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
          child: child!,
        );
      },
      firstDate: firstDate ?? DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: lastDate ?? DateTime.now());
  return selectedDate;
}
