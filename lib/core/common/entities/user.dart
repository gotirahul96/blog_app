// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gotrue/src/types/user.dart' as sb;

class User {
  final String id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});

  /// Maps Supabase Auth User to your own User model
  static User? mapSupabaseUserToDomain(sb.User? sUser) {
    if (sUser == null) return null;

    return User(
      id: sUser.id,
      email: sUser.email ?? '',
      // Supabase doesn’t have "name" by default, so check user_metadata
      name: (sUser.userMetadata?['name'] as String?) ?? '',
    );
  }
}
