part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingState extends PostsState {}


class LoadedPostsState extends PostsState{
  final List<Post> posts;

  LoadedPostsState(this.posts);

  @override
  List<Object> get props => [posts];

}
class ErrorPostsState extends PostsState
{
  final String message;

  ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];

}
