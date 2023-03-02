 import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUseCase
 {
   postsRepository postRepository;

   GetAllPostsUseCase({required this.postRepository});
   Future<Either<Failure,List<Post>>> call() async
   {
     return await postRepository.getAllPosts();
   }
}