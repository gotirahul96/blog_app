part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class UploadBlogSuccess extends BlogState {}

final class FetchBlogSuccess extends BlogState {
  final List<Blog> getBlogs;

  const FetchBlogSuccess({required this.getBlogs});
}

final class BlogFailure extends BlogState {
  final String error;

  const BlogFailure({required this.error});
}
