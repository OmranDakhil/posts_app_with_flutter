import 'package:flutter/material.dart';
class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool multiLines;
  final TextEditingController controller;
  const TextFormFieldWidget({Key? key, required this.name, required this.multiLines, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
        value!.isEmpty ? "$name can't be empty" : null,
        decoration: InputDecoration(
          hintText: name,
          hintMaxLines: multiLines?6:1,
        ),
        minLines: multiLines?6:1,
        maxLines:  multiLines?6:1,
      ),
    );


  }
}
