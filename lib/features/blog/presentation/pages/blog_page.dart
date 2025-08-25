import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/get_random_colors.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class Blogpage extends StatefulWidget {
  const Blogpage({super.key});

  @override
  State<Blogpage> createState() => _BlogpageState();
}

class _BlogpageState extends State<Blogpage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () => context.push('/add_new_blog_page'),
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          if (state is FetchBlogSuccess) {
            return ListView.builder(
              itemCount: state.getBlogs.length,
              itemBuilder: (context, index) {
                final data = state.getBlogs[index];
                return BlogCard(
                  data: data,
                  color: getRandomColor([
                    AppPallete.gradient1,
                    AppPallete.gradient2,
                    AppPallete.gradient3,
                  ]),
                );
              },
            );
          }
          return Text('No Data');
        },
      ),
    );
  }
}
