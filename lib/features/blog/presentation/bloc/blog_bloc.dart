import 'dart:io';

import 'package:blog_app/core/usercase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usercases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/usercases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogsUseCase _getBlogs;

  BlogBloc(this._uploadBlog,this._getBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) async {
      final res = await _uploadBlog(
        UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );
      res.fold((l){
        emit(BlogFailure(error: l.message));
      }, (r){
        emit(UploadBlogSuccess());
      });
    });

    on<GetBlogsEvent>((event, emit) async {
      final res = await _getBlogs(NoParams());
      res.fold((l){
        emit(BlogFailure(error: l.message));
      }, (r){
        emit(FetchBlogSuccess(getBlogs: r));
      });
    });
  }
}
