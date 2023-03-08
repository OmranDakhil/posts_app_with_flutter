import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecture/core/networks/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:posts_clean_architecture/features/posts/domin/use_cases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domin/use_cases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presention/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/posts/domin/repositories/posts_repository.dart';
import 'features/posts/domin/use_cases/delete_post.dart';
import 'features/posts/domin/use_cases/update_post.dart';

final sl = GetIt.instance;
Future<void> init() async {
  ///  features  posts

  // bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));

  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));
  // use cases
  sl.registerLazySingleton(() => AddPostUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(postRepository: sl()));
  // Repository
  sl.registerLazySingleton<postsRepository>(() => PostsRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  // data sources
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceWithHive());
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceWithDio(dio: sl()));

  /// core

  // network info

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  ///   external
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
