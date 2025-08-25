part of 'app_user_cubit.dart';


sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;
  const AppUserLoggedIn({required this.user});
}

//core cannot depend on other features
//other features can depend on code