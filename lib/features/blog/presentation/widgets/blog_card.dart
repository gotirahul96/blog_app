import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogCard extends StatelessWidget {
  final Blog data;
  final Color color;
  const BlogCard({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        context.push('/blog_viewer_page',extra: data);
      },
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: data.topics
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right : 10.0),
                      child: Chip(
                        label: Text(e),
                        color: WidgetStateProperty.all(AppPallete.backgroundColor),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(data.title,style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            )),
            Spacer(),
            Text(calculateReadTime(data.content))
          ],
        ),
      ),
    );
  }
}
