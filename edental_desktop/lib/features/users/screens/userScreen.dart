import 'package:edental_desktop/common/models/user.dart';
import 'package:edental_desktop/features/users/details/userDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/helpers/dataTableBuilder.dart';
import '../providers/userProvider.dart';
import '../services/userService.dart';

class UserScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);
    final textFieldController = TextEditingController();

    useEffect(() {
      ref.read(userNotifierProvider.notifier).loadUsers();
      return null;
    }, []);

    void searchUsers() {
      final searchTerm = textFieldController.text;
      ref.read(userNotifierProvider.notifier).searchUser(searchTerm);
    }

    void openUserDetails(int? id) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => UserDetailScreen(id)));
    }

    void openAddUserScreen() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) =>
              UserDetailScreen(null))); // Pass null to indicate a new user
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: openAddUserScreen,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Enter a search term"),
                        controller: textFieldController,
                        onChanged: (value) {
                          // Optionally, you can update the search term immediately
                          // or wait for the user to press a search button.
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: searchUsers,
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 8,
            child: userState.when(
              data: (userState) {
                final tableColumns = DataTableHelper.buildColumns<User>(
                    forPrint: true, blacklist: blackList);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: tableColumns,
                          rows: DataTableHelper.buildRows<User>(userState.users,
                              onPress: openUserDetails, blacklist: blackList),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                  ),
                  Text("Loading..."),
                ],
              ),
              error: (error, stackTrace) => Text('An error occurred: $error'),
            ),
          ),
        ],
      ),
    );
  }
}
