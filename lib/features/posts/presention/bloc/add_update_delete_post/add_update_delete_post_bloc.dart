import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/strings/done_messages.dart';
import 'package:posts_clean_architecture/features/posts/domin/use_cases/update_post.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domin/entities/post.dart';
import '../../../domin/use_cases/add_post.dart';
import '../../../domin/use_cases/delete_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddUpdateDeletePostBloc({required this.addPost, required this.updatePost, required this.deletePost}) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async{
      if(event is AddPostEvent)
        {
          emit(LoadingAddUpdateDeletePostState());
          final failureOrDoneMessage = await addPost(event.post);
           emit(_doneMessageOrErrorState(failureOrDoneMessage, ADD_POST_DONE_MESSAGE));


        }else if(event is UpdatePostEvent)
          {
            emit(LoadingAddUpdateDeletePostState());
            final failureOrDoneMessage = await updatePost(event.post);
            emit(_doneMessageOrErrorState(failureOrDoneMessage, UPDATE_POST_DONE_MESSAGE));



          }else if(event is DeletePostEvent)
            {
              emit(LoadingAddUpdateDeletePostState());
              final failureOrDoneMessage = await deletePost(event.postId);
              emit(_doneMessageOrErrorState(failureOrDoneMessage, DELETE_POST_DONE_MESSAGE));
            }
    });
  }

  AddUpdateDeletePostState _doneMessageOrErrorState(Either<Failure, Unit> either,message)
  {
    return either.fold(
            (failure) => ErrorAddUpdateDeletePostState(message: _mapFailureToMessage(failure)),
            (_) =>MessageAddUpdateDeletePostState(message: message) );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UNEXPECTED ERROR, please try again";
    }
}}
