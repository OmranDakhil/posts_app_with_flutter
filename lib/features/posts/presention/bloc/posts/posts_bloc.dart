import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/errors/failures.dart';

import '../../../../../core/strings/failures.dart';
import '../../../domin/entities/post.dart';
import '../../../domin/use_cases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UNEXCEPTED ERROR, please try again";
    }
  }
}
