import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presention/widgets/post_detail_widgets/post_detail_widget.dart';

import '../../../domin/entities/post.dart';
import '../../screens/post_detail_screen.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text(posts[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle:
                  Text(posts[index].body, style: const TextStyle(fontSize: 16)),
              leading: Text(posts[index].id.toString()),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PageDetailScreen(post: posts[index])));
              },
            ),
        separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
        itemCount: posts.length);
  }
}
