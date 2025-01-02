import 'package:dio/dio.dart';
import 'package:social_media_app/exceptions/app_exceptions.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

// fetch the posts from api
  Future<List<PostModel>> fetchPosts() async {
    try {
      final data = await handleApiRequest(() async {
        return await _dio.get('/posts');
      });
      return (data as List).map((json) => PostModel.fromJson(json)).toList();
    } on ApiException catch (e) {
      print('API Error: ${e.statusCode} - ${e.message}');
      throw Exception(e);
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

// create a new post from post api
  Future<PostModel> createPost(PostModel post) async {
    try {
      final response = await _dio.post('/posts', data: post.toJson());
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

// fetch the comments from api
  Future<List<CommentModel>> fetchComments(int postId) async {
    try {
      final data = await handleApiRequest(() async {
        return await _dio.get('/posts/$postId/comments');
      });
      return (data as List).map((json) => CommentModel.fromJson(json)).toList();
    } on ApiException catch (e) {
      print('API Error: ${e.statusCode} - ${e.message}');
      throw Exception(e);
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

//  fetch the users data in api
  Future<UsersModel> fetchUsers(int userId) async {
    try {
      final data = await await handleApiRequest(() async {
        return await _dio.get('/users/$userId');
      });
      return UsersModel.fromJson(data);
    } on ApiException catch (e) {
      print('API Error: ${e.statusCode} - ${e.message}');
      throw Exception(e);
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }
}
