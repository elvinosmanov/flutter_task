import 'package:flutter/cupertino.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/repositories/user_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/users.dart';

class HomeProvider extends ChangeNotifier {
  final userRepository = UserRepository();
  final PagingController<int, UserModel> _pagingController = PagingController(firstPageKey: 1);
  PagingController<int, UserModel> get pagingController => _pagingController;
  void pageAddListener() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void pageRemoveListener() {
    _pagingController.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final apiResponse = await userRepository.getAllUsers(pageKey);
      
      //For testing purpose
      await Future.delayed(const Duration(seconds: 2));

      final usersData = (apiResponse.data as Users);
      final isLastPage = usersData.totalPages <= usersData.page;
      if (!isLastPage) {
        pageKey += 1;
        _pagingController.appendPage(usersData.userDataList, pageKey);
      } else {
        _pagingController.appendLastPage(usersData.userDataList);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
