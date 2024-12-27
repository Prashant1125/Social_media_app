import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final Map<String, dynamic>? data;
// kuchh bta
  ApiException({required this.statusCode, required this.message, this.data});

  @override
  String toString() {
    return 'ApiException: $statusCode - $message\nData: $data';
  }
}

Future<dynamic> handleApiRequest(Future<Response> Function() request) async {
  try {
    final response = await request();

    if (response.statusCode == 200) {
      // Success
      if (response.data.isNotEmpty) {
        return response.data;
      } else {
        return null;
      }
    } else {
      // Handle non-2xx status codes
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API Error: ${response.statusCode}',
        data: jsonDecode(response.data),
      );
    }
  } catch (e) {
    // Handle other exceptions (e.g., network errors, timeouts)
    rethrow; // Re-throw the exception to be handled by the caller
  }
}
