import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/constants.dart';
import 'package:social_media_app/constant/customfield.dart';
import '../models/controllers/post_controller.dart';
import '../models/post_model.dart';
import 'post_detail_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final PostsController postsController = Get.put(PostsController());

  HomeScreen({super.key}) {
    postsController.fetchPosts(); // Fetch posts on initialization
  }

  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
          leading: const Icon(Icons.home_outlined),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => addPosts(context),
          label: const Text('Create new Post'),
        ),
        body: Obx(() {
          if (postsController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postsController.posts.isEmpty) {
            return const Center(child: Text('No posts found'));
          }
          return ListView.builder(
            itemCount: postsController.posts.length,
            itemBuilder: (context, index) {
              final post = postsController.posts[index];
              return Card(
                color: Colors.blue.shade50,
                child: ListTile(
                  onTap: () {
                    Get.to(() => PostDetailScreen(post: post));
                  },
                  leading: Text(
                    (index + 1).toString(),
                    style: namestyle,
                  ),
                  title: Text(
                    post.title.toString(),
                    maxLines: 1,
                    style: namestyle.copyWith(fontSize: 15),
                  ),
                  subtitle: Text(
                    'Description : ${post.body.toString()}',
                    style: subtitle,
                    maxLines: 2,
                  ),
                ),
              );
            },
          );
        }));
  }

  void addPosts(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue.shade50,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Add new post',
                    style: namestyle.copyWith(fontSize: 25),
                  ),
                  CstmTxtField(
                    controller: titleController,
                    hintText: 'Enter title',
                    labelText: 'Title',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                  ),
                  CstmTxtField(
                    controller: bodyController,
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade200),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newPost = PostModel(
                              id: 0,
                              title: titleController.text,
                              body: bodyController.text,
                              userId: 1,
                            );
                            await postsController.createPost(newPost);
                            titleController.clear();
                            bodyController.clear();
                            Get.back();
                            Get.snackbar(
                                newPost.title.toString(), 'New post added',
                                backgroundColor: Colors.blue.shade50);
                          }
                        },
                        child: const Text('Add post')),
                  )
                ],
              ),
            ),
          );
        });
  }
}
