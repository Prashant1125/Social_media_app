import 'package:get/get.dart';
import 'package:social_media_app/models/comment_model.dart';
import '../../api/api_service.dart';

class CommentsController extends GetxController {
  final ApiService _apiService = ApiService();
  var comments = <CommentModel>[].obs;
  var isLoading = true.obs;

  void fetchComments(int postId) async {
    try {
      isLoading(true);
      comments.value = await _apiService.fetchComments(postId);
    } catch (e) {
      print('Error fetching comments: $e');
    } finally {
      isLoading(false);
    }
  }
}
