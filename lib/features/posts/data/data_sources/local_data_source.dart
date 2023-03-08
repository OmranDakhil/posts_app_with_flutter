import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:posts_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_clean_architecture/core/strings/constants.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domin/entities/post.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

const CACHED = 'CACHED_POSTS';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    final postModelsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    final postModelsEncoded = json.encode(postModelsToJson);
    sharedPreferences.setString(CACHED, postModelsEncoded);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonPostModels = sharedPreferences.getString(CACHED);
    if (jsonPostModels != null) {
      List decodedData = json.decode(jsonPostModels);
      final List<PostModel> cachedPosts = decodedData
          .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
          .toList();
      return Future.value(cachedPosts);
    }else
      {
          throw EmptyCacheException();
      }
  }
}

class LocalDataSourceWithHive extends LocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> posts) async{

    Box<Post> articlesBox=await Hive.openBox<Post>(kArticlesBox);

    await articlesBox.addAll(posts);
    await articlesBox.close();
    return Future.value(unit);

  }

  @override
  Future<List<PostModel>> getCachedPosts() async{

   Box<Post> articlesBox=await Hive.openBox<Post>(kArticlesBox);
    List<PostModel> posts=[];
    if(articlesBox.values.toList().isNotEmpty){
      articlesBox.values.toList().forEach((post) {
        posts.add(PostModel(id: post.id,title: post.title, body: post.body));
      });
      await articlesBox.close();
      return Future.value(posts);
    }
    else{
      throw EmptyCacheException();
    }

  }

}
