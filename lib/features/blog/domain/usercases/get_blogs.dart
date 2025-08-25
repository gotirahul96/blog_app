

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usercase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogsUseCase implements Usecase<List<Blog>,NoParams>{

  final BlogRepository blogRepository;

  GetBlogsUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getBlogs(); 
  }
  
}

