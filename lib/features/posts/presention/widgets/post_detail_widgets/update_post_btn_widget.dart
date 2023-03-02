import '../../../domin/entities/post.dart';
import 'package:flutter/material.dart';

import '../../screens/post_add_update_screen.dart';
class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostAddUpdateScreen(
                  isUpdatePost: true, post: post)));
        },
        icon: Icon(Icons.edit),
        label: Text("Edit"));
  }
}
