import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvcs_example/core/models/user_model.dart';
import 'package:mvcs_example/core/services/user_service.dart';

final usersProvider =
    StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<List<User>>>(
        (ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  late final UserService _userService;

  UserNotifier(this._ref) : super(const AsyncValue.data(<User>[])) {
    _userService = _ref.watch(userService);
  }

  Future<void> getUsers() async {
    state = const AsyncValue.loading();
    final res =
        await AsyncValue.guard(() async => await _userService.getUser());
    state = AsyncValue.data(res.asData!.value);
  }
}
