import 'package:flutter/material.dart';

class UploadButton extends FormField<String> {
  UploadButton(
      {FormFieldSetter<String>? onSaved,
      FormFieldValidator<String>? validator,
      String initialValue = '',
      required String title,
      Function()? onPress,
      Widget? leading,
      Widget? trailing,
      String? id,
      bool showBorder = false
      // bool autovalidate = false
      })
      : super(
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<String> field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    key: ValueKey(id),
                    shape: showBorder
                        ? RoundedRectangleBorder(
                            side: BorderSide(
                                color: field.hasError
                                    ? Colors.red
                                    : Colors.black38),
                            borderRadius: BorderRadius.circular(4))
                        : null,
                    minLeadingWidth: 0,
                    dense: true,
                    title: Text(title,
                        style: Theme.of(field.context).textTheme.bodyMedium),
                    trailing: trailing ?? Icon(Icons.upload),
                    leading: leading,
                    onTap: onPress,
                    contentPadding: EdgeInsets.fromLTRB(2, 0, 6, 0),
                  ),
                  field.hasError
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
                          child: Text(
                            field.errorText ?? '',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              );
            });
}
