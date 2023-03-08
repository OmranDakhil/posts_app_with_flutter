import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:posts_clean_architecture/core/strings/constants.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/posts/posts_bloc.dart';
import 'features/posts/presention/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presention/screens/posts_screen.dart';
import 'injection_container.dart' as di;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider<AddUpdateDeletePostBloc>(
          create: (context) => di.sl<AddUpdateDeletePostBloc>(),
        ),
      ],
      child: MaterialApp(
        title: "Posts App",
        debugShowCheckedModeBanner: false,
        home: PostsScreen(),

        ),

    );
  }

}


