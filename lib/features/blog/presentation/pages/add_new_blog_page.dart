import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void uploadBlog(){
     if (formKey.currentState!.validate() && selectedTopics.isNotEmpty && image != null) {
                //serviceLocator<SupabaseClient>().auth.signOut();
              context.read<BlogBloc>().add(
                BlogUpload(
                  posterId: (serviceLocator<AppUserCubit>().state as AppUserLoggedIn).user.id,
                  title: titleController.text.trim(),
                  content: contentController.text.trim(),
                  image: image!,
                  topics: selectedTopics,
                ),
              );
              }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => uploadBlog(),
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
            if (state is UploadBlogSuccess) {
              context.pushReplacement('/home');
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => selectImage(),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(5),
                                child: Image.file(
                                  image!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : DottedBorder(
                                options: RectDottedBorderOptions(
                                  dashPattern: const [10, 4],
                                  strokeWidth: 2,
                                  strokeCap: StrokeCap.round,
                                  color: AppPallete.whiteColor,
                                  padding: EdgeInsets.all(16),
                                ),
      
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.folder_open, size: 40),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              [
                                    "Technology",
                                    "Business",
                                    "Programming",
                                    "Entertainment",
                                  ]
                                  .map(
                                    (a) => Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedTopics.contains(a)) {
                                              selectedTopics.remove(a);
                                            } else {
                                              selectedTopics.add(a);
                                            }
                                          });
                                        },
                                        child: Chip(
                                          label: Text(a),
                                          color: selectedTopics.contains(a)
                                              ? WidgetStateProperty.all(
                                                  AppPallete.gradient1,
                                                )
                                              : null,
                                          side: const BorderSide(
                                            color: AppPallete.borderColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlogEditor(
                        controller: titleController,
                        hintText: "Blog title",
                      ),
                      const SizedBox(height: 15),
                      BlogEditor(
                        controller: contentController,
                        hintText: "Blog Content",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
