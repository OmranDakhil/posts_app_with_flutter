import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presention/screens/post_add_update_screen.dart';

import '../../domin/entities/post.dart';
import '../widgets/post_detail_widgets/post_detail_widget.dart';

class PageDetailScreen extends StatelessWidget {
  final Post post;
  const PageDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: PostDetailWidget(post:post),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("post detail"),
      );
}
