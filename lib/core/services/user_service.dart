import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvcs_example/core/models/user_model.dart';

final userService = Provider((ref) => UserService());

class UserService {
  Future<List<User>> getUser() async {
    try {
      const path = 'https://jsonplaceholder.typicode.com/users';
      final res = await Dio().get(path);
      final List list = res.data;
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
