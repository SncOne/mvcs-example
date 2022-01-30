import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvcs_example/core/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getUsers = ref.watch(usersProvider.notifier);
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(),
      body: users.when(
        data: (list) {
          final newList = list;
          if (newList.isEmpty) {
            return const Center(child: Text('There is no user'));
          }
          return ListView.builder(
            itemCount: newList.length,
            itemBuilder: (_, i) {
              final user = newList[i];
              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${user.name}'),
                        Text('${user.website}'),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
        error: (_, __) => const Center(child: Text('err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getUsers.getUsers();
        },
      ),
    );
  }
}
