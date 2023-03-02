

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/screens/post_add_update_screen.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_Widgets/message_display_widget.dart';
import '../widgets/posts_Widgets/posts_list_widget.dart';
class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatActionBtn(context),
    );
  }


  AppBar _buildAppBar()=>AppBar(title: Text("Posts"));

  Widget _buildBody()=>Padding(padding: EdgeInsets.all(10),
    child: BlocBuilder<PostsBloc,PostsState>
      (builder:(context,state)
    {
      if(state is LoadingState)
        return LoadingWidget();
      else if(state is LoadedPostsState)
        return RefreshIndicator(
          onRefresh: ()=>_onRefresh(context),
          child: PostsListWidget(
              posts:state.posts
          ),
        );
      else if (state is ErrorPostsState)
        return messageDisplyWidget(
            message:state.message
        );
      return LoadingWidget();

    }),
  );
  Widget _buildFloatActionBtn(BuildContext context)=>FloatingActionButton(onPressed: (){
    
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PostAddUpdateScreen(isUpdatePost: false)));
  }
    ,child: const Icon(Icons.add),);

  Future<void> _onRefresh(BuildContext context) async{
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }





}
