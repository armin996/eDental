import 'package:edental_desktop/common/helpers/dataTableBuilder.dart';
import 'package:edental_desktop/common/models/dentist.dart';
import 'package:edental_desktop/features/dentists/details/dentist_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../provider/dentistProvider.dart';

class DentistScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(dentistNotifierProvider);

    final textFieldController = TextEditingController();

    void _searchDentists() {
      final searchTerm = textFieldController.text;
      ref.read(dentistNotifierProvider.notifier).searchDentists(searchTerm);
    }

    void _resetSearch() {
      textFieldController.clear();
      ref.read(dentistNotifierProvider.notifier).loadDentists();
    }

    void openDentistDetails(int? id) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => DentistDetailScreen(id)));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dentists"), actions: [
        IconButton(onPressed: _resetSearch, icon: const Icon(Icons.refresh)),
        IconButton(
            onPressed: () => openDentistDetails(null),
            icon: const Icon(Icons.add))
      ]),
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
                    onPressed: _searchDentists,
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 8,
            child: searchResults.when(
              data: (state) {
                final tableColumns = DataTableHelper.buildColumns<Dentist>(
                    forPrint: true, blacklist: blackList);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: tableColumns,
                          rows: DataTableHelper.buildRows<Dentist>(
                              state.dentists,
                              onPress: openDentistDetails,
                              blacklist: blackList),
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
              error: (_, __) => const Center(
                  child: Text('An error occurred while searching.')),
            ),
          ),
        ],
      ),
    );
  }
}
