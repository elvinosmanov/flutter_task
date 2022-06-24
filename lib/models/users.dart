import 'package:flutter_task/models/user.dart';

class Users {
  final List<UserModel> userDataList;
  final int page;
  final int totalPages;
  Users({
    required this.userDataList,
    required this.page,
    required this.totalPages,
  });

  Map<String, dynamic> toMap() {
    return {
      'userDataList': userDataList.map((x) => x.toMap()).toList(),
      'page': page,
      'totalPages': totalPages,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userDataList: List<UserModel>.from(map['data'].map((model) => UserModel.fromJson(model))),
      page: map['page']?.toInt() ?? 0,
      totalPages: map['total_pages']?.toInt() ?? 0,
    );
  }
}
