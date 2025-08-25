import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/routes/router_config.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/usercases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/usercases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/blog/domain/repositories/blog_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaBaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(internetConnection: serviceLocator()));
  serviceLocator.registerLazySingleton<GoRouter>(() {
    final cubit = serviceLocator<AppUserCubit>();
    return Routes.build(cubit);
  });
  _initAuth();
  _initBlog();
}

void _initAuth() {
  //DataSouce
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(),serviceLocator<ConnectionChecker>()),
    )
    //useCases
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initBlog(){
  //DataSource 
  serviceLocator
  ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(client: serviceLocator<SupabaseClient>()))
  //Repository
  ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(blogRemoteDataSource: serviceLocator()))
  //useCases 
  ..registerFactory(() => UploadBlog(blogRepository: serviceLocator<BlogRepository>()))
  ..registerFactory(() => GetBlogsUseCase(blogRepository: serviceLocator<BlogRepository>()))
  //bloc
  ..registerLazySingleton(() => BlogBloc(serviceLocator(),serviceLocator()));
}
