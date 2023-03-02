part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostEvent extends Equatable {
  const AddUpdateDeletePostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  AddPostEvent({required this.post});
  @override
  // TODO: implement props
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  // TODO: implement props
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => [postId];
}
