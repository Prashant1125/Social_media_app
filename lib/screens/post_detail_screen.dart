import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/constants.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/screens/user_profile_screen.dart';
import '../models/controllers/comment_controller.dart';
import '../models/controllers/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel? post;
  PostDetailScreen({super.key, required this.post});

  final CommentsController commentsController = Get.put(CommentsController());
  final PostsController postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    commentsController.fetchComments(post?.id ?? 0);

    return Scaffold(
        appBar: AppBar(title: const Text('Post Detail')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(UsersProfileScreen(userId: post?.userId));
          },
          label: const Text("User Detail"),
        ),
        body: ListView(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              color: Colors.blue.shade50,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post?.title ?? "",
                      style: namestyle.copyWith(fontSize: 18),
                    ),
                    Text(
                      post?.body ?? "",
                      style: subtitle,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Comments',
              style: namestyle,
            ),
            Obx(() {
              if (commentsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (commentsController.comments.isEmpty) {
                return const Center(child: Text('No Comment found'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commentsController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentsController.comments[index];
                  return Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: ListTile(
                      title: Text('User : ${comment.email.toString()}'),
                      subtitle: Text(comment.body.toString()),
                    ),
                  );
                },
              );
            }),
          ],
        ));
  }
}
