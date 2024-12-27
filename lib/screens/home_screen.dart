import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/constants.dart';
import '../models/controllers/post_controller.dart';
import 'post_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostsController postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
          leading: const Icon(Icons.home_outlined),
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
                    post.id.toString(),
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
}
