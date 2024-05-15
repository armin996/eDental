import 'package:edental_desktop/common/models/treatment.dart';
import 'package:edental_desktop/features/treatments/screens/treatmentDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/helpers/dataTableBuilder.dart';
import '../providers/treatmentProvider.dart';

class TreatmentScreen extends HookConsumerWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treatmentState = ref.watch(treatmentNotifierProvider);
    final textFieldController = TextEditingController();

    useEffect(() {
      ref.read(treatmentNotifierProvider.notifier).loadTreatments();
      return null;
    }, []);

    void _searchTreatments() {
      final searchTerm = textFieldController.text;
      ref.read(treatmentNotifierProvider.notifier).searchTreatments(searchTerm);
    }

    void openTreatmentDetails(int? id) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => TreatmentDetailScreen(id)));
    }

    void _resetSearch() {
      textFieldController.clear();
      ref.read(treatmentNotifierProvider.notifier).loadTreatments();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Treatments"),
        actions: [
          IconButton(onPressed: _resetSearch, icon: const Icon(Icons.refresh)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openTreatmentDetails(null),
          )
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
                          controller: textFieldController),
                    ),
                  ),
                  TextButton(
                    onPressed: _searchTreatments,
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 8,
            child: treatmentState.when(
              data: (treatmentState) {
                final tableColumns = DataTableHelper.buildColumns<Treatment>(
                    forPrint: true, blacklist: blackList);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: tableColumns,
                          rows: DataTableHelper.buildRows<Treatment>(
                              treatmentState.treatments,
                              onPress: openTreatmentDetails,
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
              error: (error, stackTrace) => Text('An error occurred: $error'),
            ),
          ),
        ],
      ),
    );
  }
}
