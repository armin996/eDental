import 'package:edental_desktop/features/appointments/screens/appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class SidebarController extends StateNotifier<int> {
  SidebarController() : super(0);

  void selectMenuItem(int index) {
    state = index;
  }
}

final sidebarControllerProvider =
    StateNotifierProvider<SidebarController, int>((ref) => SidebarController());

class Sidebar extends HookConsumerWidget {
  final List<String> menuItems;
  final List<Widget Function()> screens;
  Sidebar({required this.menuItems, required this.screens});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = ref.watch(sidebarControllerProvider);
    return Drawer(
      child: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(menuItems[index]),
            selected: selectedIndex == index,
            onTap: () {
              ref.watch(sidebarControllerProvider.notifier).state = index;
            },
          );
        },
      ),
    );
  }
}
