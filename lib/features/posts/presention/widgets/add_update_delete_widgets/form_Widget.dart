import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/widgets/add_update_delete_widgets/text_form_field_widget.dart';

import '../../../domin/entities/post.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;
  const FormWidget({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController title_controller = TextEditingController();
  TextEditingController body_controller = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      title_controller.text = widget.post!.title;
      body_controller.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // textField  . title
            TextFormFieldWidget(name:"Title",multiLines:false,controller:title_controller),
            TextFormFieldWidget(name:"Body",multiLines:true,controller:body_controller),

            FormSubmitBtn(onPressed:_validiteThenUpdateOrAddPost,isUpdate:widget.isUpdate)

          ],
        ));
  }

  void _validiteThenUpdateOrAddPost() {
    final valdite = formKey.currentState!.validate();
    if (valdite) {
      final post = Post(
          id: widget.isUpdate ? widget.post!.id : null,
          title: title_controller.text,
          body: body_controller.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
