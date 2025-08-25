// ignore_for_file: public_member_api_docs, sort_constructors_first

class Blog {
  final String id;
  final String postId;
  final String? posterName;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updateAt;

  Blog({
    required this.id,
    required this.postId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updateAt,
    this.posterName
  });

 

}
