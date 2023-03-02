import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUseCase
{
  postsRepository postRepository;

  UpdatePostUseCase({required this.postRepository});
  Future<Either<Failure,Unit>> call(Post post) async
  {
    return await postRepository.updatePost(post);
  }
}