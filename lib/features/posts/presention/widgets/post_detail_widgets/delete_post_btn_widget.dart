import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snakbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../../screens/posts_screen.dart';
import 'delete_dailog_widget.dart';
class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget( {Key? key,required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ()=>deleteDailog(context,postId),
      icon: Icon(Icons.delete),
      label: Text("Delete"),
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Colors.redAccent)),
    );
  }
  deleteDailog(BuildContext context,int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostBloc,AddUpdateDeletePostState>(
            builder: (context, state) {
              if(state is LoadingAddUpdateDeletePostState){
                return AlertDialog(title: LoadingWidget(),);
              }
              return DeleteDailogWidget(postId: postId);
            },
            listener: (context, state) {
              if (state is MessageAddUpdateDeletePostState) {
                SnakBarMessage().showSucessSnakbar(
                    context: context, message: state.message);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostsScreen()),
                        (route) => false);
              }
              else if (state is ErrorAddUpdateDeletePostState) {
                Navigator.of(context).pop();
                SnakBarMessage()
                    .showErrorSnakbar(context: context, message: state.message);
              }
            },
          );
        });
  }
}
