import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final List<PostModel> chachedPosts = decodedData
          .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
          .toList();
      return Future.value(chachedPosts);
    }else
      {
          throw EmptyCacheException();
      }
  }
}
