import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int id);
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
}
const BASE_URL="https://jsonplaceholder.typicode.com";
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final http.Response response = await client.get(Uri.parse(BASE_URL+"/posts/") );
    if (response.statusCode == 200) {
      List decodedData = json.decode(response.body);
      final List<PostModel> posts = decodedData
          .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
          .toList();
      return Future.value(posts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {'title': post.title, 'body': post.body};
    final http.Response response = await client.post(Uri.parse(BASE_URL+"/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final http.Response response = await client.delete(Uri.parse(BASE_URL+"/posts/${id.toString()}"));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id;
    final body = {'title': post.title, 'body': post.body};
    final http.Response response = await client.post(Uri.parse(BASE_URL+"/posts/${postId.toString()}"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}









class RemoteDataSourceWithDio implements RemoteDataSource{
  final Dio dio;

  RemoteDataSourceWithDio({required this.dio});

  @override
  Future<Unit> addPost(PostModel post) async{
    
    final data = {'title': post.title, 'body': post.body};
    Response response=await dio.post("$BASE_URL/posts/",data: data);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async{
    final Response response = await dio.delete("$BASE_URL/posts/${id.toString()}");
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async{
    Response<List> response=await dio.get("$BASE_URL/posts/");

    if(response.statusCode==200)
      {
        //List decodedData = json.decode(response.data.t);

         List<PostModel> posts=[];
         for (var jsonPostModel in response.data!) {
          posts.add(PostModel.fromjson(jsonPostModel));
        }
        return Future.value(posts);
      }
    else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async{
    final postId = post.id;
    final data = {'title': post.title, 'body': post.body};
    final Response response = await dio.put("$BASE_URL/posts/${postId.toString()}", data: data);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }


}
