import 'package:flutter/material.dart';
class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdate;
  const FormSubmitBtn({Key? key, required this.onPressed, required this.isUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdate ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdate ? "edit" : "add"));
  }
}
