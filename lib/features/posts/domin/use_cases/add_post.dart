import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class AddPostUseCase
{
  postsRepository postRepository;

  AddPostUseCase({required this.postRepository});
  Future<Either<Failure,Unit>> call(Post post) async
  {
    return await postRepository.addPost(post);
  }
}