import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<String> uploadBlogImage({
    required File? image,
    required BlogModel blog,
  });
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final SupabaseClient client;
  BlogRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await client.from('blogs').select("*, profiles (name)");
      return blogs.map((e) => BlogModel.fromJson(e).copyWith(posterName: e['profiles']['name'])).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await client
          .from("blogs")
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File? image,
    required BlogModel blog,
  }) async {
    try {
      await client.storage.from("blog_images").upload(blog.id, image!);
      return client.storage.from("blog_images").getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
