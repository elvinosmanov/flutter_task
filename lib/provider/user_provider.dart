import 'package:flutter/cupertino.dart';
import 'package:flutter_task/models/api_response.dart';
import 'package:flutter_task/repositories/user_repository.dart';

import '../models/user.dart';
import '../service/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  set userModel(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;
  set loginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }
   bool _registerLoading = false;
  bool get registerLoading => _registerLoading;
  set registerLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }
  

  bool _updateUserLoading = false;
  bool get updateUserLoading => _updateUserLoading;
  set updateUserLoading(bool value) {
    _updateUserLoading = value;
    notifyListeners();
  }

  Future<ApiResponse> getUser() async {
    final apiResponse = await UserRepository().getUser();
    userModel = apiResponse.data as UserModel;
    return apiResponse;
  }
  Future<ApiResponse> updateUser(Map map) async {
    updateUserLoading = true;
    final apiResponse = await UserRepository().updateUser( map);
    userModel = apiResponse.data as UserModel;
    updateUserLoading = false;

    return apiResponse;
  }
  

  Future<ApiResponse> loginUser(String email, String password) async {
    loginLoading = true;
    final apiResponse = await AuthService().loginUser(email, password);
    loginLoading = false;
    return apiResponse;
  }

  Future<ApiResponse> registerUser(String email, String password) async {
    loginLoading = true;
    final apiResponse = await AuthService().registerUser(email, password);
    loginLoading = false;
    return apiResponse;
  }
}
