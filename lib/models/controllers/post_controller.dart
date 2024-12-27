import 'package:get/get.dart';
import 'package:social_media_app/models/post_model.dart';
import '../../api/api_service.dart';

class PostsController extends GetxController {
  final ApiService _apiService = ApiService();
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      posts.value = await _apiService.fetchPosts();
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading(false);
    }
  }
}
