import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/util/snakbar_message.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/screens/posts_screen.dart';

import '../../domin/entities/post.dart';
import '../widgets/add_update_delete_widgets/form_Widget.dart';


class PostAddUpdateScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdateScreen({Key? key, this.post, required this.isUpdatePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),

    );
}

  AppBar _buildAppBar() =>AppBar(title: Text(isUpdatePost ? "edit post":" add post"),);
  Widget _buildBody()
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc,AddUpdateDeletePostState>
          (builder: (context, state) {
          if(state is LoadingAddUpdateDeletePostState) {
            return const LoadingWidget();
          }
          return FormWidget(post:isUpdatePost ? post:null, isUpdate: isUpdatePost);
        }, listener: (context, state) {
          if(state is MessageAddUpdateDeletePostState)
            {
              SnakBarMessage().showSucessSnakbar(context: context, message: state.message);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>PostsScreen()), (route) => false);
            }
          if(state is ErrorAddUpdateDeletePostState)
          {
            SnakBarMessage().showSucessSnakbar(context: context, message: state.message);

          }
        },),
      ),
    );
  }
  }



