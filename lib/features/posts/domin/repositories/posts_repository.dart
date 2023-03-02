import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';

import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
abstract class postsRepository
{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> addPost(Post post);
}