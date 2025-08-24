import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usercase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>((event, emit) async {
      //emit(AuthLoading());
      final res = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );
      res.fold(
        (l) {
          emit(AuthFailure(message: l.message));
        },
        (r) {
          _emitAuthSuccess(r,emit);
        },
      );
    });
    on<AuthSignIn>((event, emit) async {
      //emit(AuthLoading());
      final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password),
      );
      res.fold(
        (l) {
          emit(AuthFailure(message: l.message));
        },
        (r) {
          _emitAuthSuccess(r,emit);
        },
      );
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold(
        (l) {
          emit(AuthFailure(message: l.message));
        },
        (r) {
          _emitAuthSuccess(r,emit);
        },
      );
    });
    // on<AuthIsUserLoggedIn>((event, emit) async {
    //   emit(AuthSuccess(user: event));
    // });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
