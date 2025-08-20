import 'package:flutter/material.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

}

extension StringExtension on String {
  bool isValidWebsite() {
    return RegExp(
        r"^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/\S*)?$"
    ).hasMatch(this);
  }
}


extension NullAndEmptyCheck on String? {
  bool isNullOrEmpty() {
    if (this == null) {
      return true;
    } else if (this?.length == 0) {
      return true;
    }
    return false;
  }
}

extension isNumber on String? {
  bool isNumeric() {
    if (this == null) {
      return false;
    }
    return int.tryParse(this!) != null;
  }
}

extension BooleanParsing on String {
  bool toBoolean() {
    if (toLowerCase() == "true") {
      return true;
    }
    return false;
  }
}

extension Ex on String {
  String toPrecision(int n) {
    try {
      return double.parse(this).toStringAsFixed(n);
    } catch (e) {}
    return this;
  }
}

extension ThemeExt on BuildContext {
  TextStyle? titleLarge() {
    return Theme.of(this).textTheme.titleLarge;
  }

  TextStyle? titleMedium() {
    return Theme.of(this).textTheme.titleMedium;
  }

  TextStyle? titleSmall() {
    return Theme.of(this).textTheme.titleSmall;
  }

  TextStyle? bodyLarge() {
    return Theme.of(this).textTheme.bodyLarge;
  }

  TextStyle? bodyMedium() {
    return Theme.of(this).textTheme.bodyMedium;
  }

  TextStyle? bodySmall() {
    return Theme.of(this).textTheme.bodySmall;
  }
}

extension WidgetExt on Widget {
  Widget centre() {
    return Center(
      child: this,
    );
  }

  Widget sizedBox({double? width, double? height}) {
    return SizedBox(
      child: this,
      width: width,
      height: height,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  Widget flexible({int flex = 1}) {
    return Flexible(flex: flex, child: this);
  }

  Widget align(Alignment alignment) {
    return Align(alignment: alignment, child: this);
  }

  Widget scrollable({Axis scrollDirection = Axis.vertical}) {
    return SingleChildScrollView(scrollDirection: scrollDirection, child: this);
  }

  Widget padding(EdgeInsets inset) {
    return Padding(
      padding: inset,
      child: this,
    );
  }
}

extension SizedBoxExt on int {
  Widget height() {
    return SizedBox(
      height: this.toDouble(),
    );
  }

  Widget width() {
    return SizedBox(
      width: this.toDouble(),
    );
  }
}
