import 'dart:convert';

import 'package:flutter_task/constants.dart';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';


class AuthService {
  Future<ApiResponse> loginUser(String email, String password) async {
    ApiResponse apiResponse =  ApiResponse();
    try {
      final response =
          await http.post(Uri.parse('$baseURL/api/login'), body: {'email': email, 'password': password});
          final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
         apiResponse.data = ApiToken.fromJson(json);
      } else {
         apiResponse.apiError = ApiError.fromJson(json);
      }
      
    } catch (e) {
      throw Exception('Error: $e');
    }
    return apiResponse;
  }
  
  Future<ApiResponse> registerUser(String email, String password) async {
    ApiResponse apiResponse =  ApiResponse();
    try {
      final response =
          await http.post(Uri.parse('$baseURL/api/register'), body: {'email': email, 'password': password});
          final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
         apiResponse.data = ApiToken.fromJson(json);
      } else {
         apiResponse.apiError = ApiError.fromJson(json);
      }
      
    } catch (e) {
      throw Exception('Error: $e');
    }
    return apiResponse;
  }
}
