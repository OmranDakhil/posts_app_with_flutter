import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_clean_architecture/core/errors/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecture/features/posts/domin/entities/post.dart';
import '../../../../core/networks/network_info.dart';
import '../../domin/repositories/posts_repository.dart';
import '../data_sources/local_data_source.dart';

class PostsRepositoryImpl implements postsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostsRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel =
        PostModel( title: post.title, body: post.body);
    return await _getMassege(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMassege(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMassege(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMassege(
      Future<Unit> Function() addOrUpdateOrDelete) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrUpdateOrDelete();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
