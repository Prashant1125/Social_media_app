import 'package:get/get.dart';
import 'package:social_media_app/models/post_model.dart';
import '../../api/api_service.dart';

class PostsController extends GetxController {
  final ApiService _apiService = ApiService();
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

// fetch all posts
  Future<void> fetchPosts() async {
    isLoading(true);
    try {
      final fetchedPosts = await _apiService.fetchPosts();
      posts.assignAll(fetchedPosts);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new post
  Future<void> createPost(PostModel post) async {
    try {
      final newPost = await _apiService.createPost(post);
      posts.add(newPost); // Update the list with the new post
    } catch (e) {
      error.value = e.toString();
    }
  }
}
