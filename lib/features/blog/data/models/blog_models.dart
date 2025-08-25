import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.postId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updateAt,
    super.posterName
  });

  /// Factory constructor to create a BlogModel from JSON
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      postId: json['poster_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      topics: List<String>.from(json['topics'] ?? []),
      updateAt: json['updated_at'] == null ? DateTime.now() : DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert BlogModel instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': postId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updateAt.toIso8601String(),
    };
  }


  BlogModel copyWith({
    String? id,
    String? postId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updateAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updateAt: updateAt ?? this.updateAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
