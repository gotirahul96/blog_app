import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blogData;
  const BlogViewerPage({super.key, required this.blogData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogData.title,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blogData.posterName}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${DateFormat.yMMMMd('en_US').format(blogData.updateAt)} . ${calculateReadTime(blogData.content)}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  child: Image.network(
                    blogData.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(blogData.content,style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
