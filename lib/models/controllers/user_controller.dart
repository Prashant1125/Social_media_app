import 'package:get/get.dart';
import 'package:social_media_app/models/user_model.dart';
import '../../api/api_service.dart';

class UsersController extends GetxController {
  final ApiService _apiService = ApiService();
  var users = UsersModel().obs;
  var isLoading = true.obs;

  void fetchUsers(int userId) async {
    try {
      isLoading(true);
      users.value = await _apiService.fetchUsers(userId);
    } catch (e) {
      print('Error fetching user: $e');
    } finally {
      isLoading(false);
    }
  }
}
