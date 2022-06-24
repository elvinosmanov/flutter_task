import 'dart:convert';

import 'package:flutter_task/constants.dart';
import 'package:flutter_task/models/api_response.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/models/users.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<ApiResponse> getAllUsers(int pageNumber) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(Uri.parse('$baseURL/api/users?page=$pageNumber'));
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        apiResponse.data = Users.fromMap(result);
      } else {
        apiResponse.apiError = ApiError.fromJson(result);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return apiResponse;
  }

  Future<ApiResponse> getUser() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(Uri.parse('$baseURL/api/users/2'));
      final json = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        apiResponse.data = UserModel.fromJson(json['data']);
        print((apiResponse.data as UserModel).toString());
      } else {
        apiResponse.apiError = ApiError.fromJson(json);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return apiResponse;
  }

  Future<ApiResponse> updateUser(Map map) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.put(Uri.parse('$baseURL/api/users/2'), body: map);
      final json = jsonDecode(response.body);
      print("vody" + response.body);
      if (response.statusCode == 200) {
        apiResponse.data = UserModel.fromJson(json);
      } else {
        apiResponse.apiError = ApiError.fromJson(json);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return apiResponse;
  }
}
