import 'package:fpdart/src/either.dart';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usercase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User, NoParams> {

  final AuthRepository authRepository;
  const CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}

