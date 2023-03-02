import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../repositories/posts_repository.dart';

class DeletePostUseCase
{
  postsRepository postRepository;

  DeletePostUseCase({required this.postRepository});
  Future<Either<Failure,Unit>> call(int id) async
  {
    return await postRepository.deletePost(id);
  }
}