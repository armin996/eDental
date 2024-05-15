import 'package:edental_desktop/common/helpers/dataTableBuilder.dart';
import 'package:edental_desktop/common/models/report.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../providers/reportProvider.dart';

class ReportScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(reportNotifierProvider);

    final selectedDateRange = useState<DateTimeRange?>(null);
    final textFieldController = TextEditingController();
    void _showDateRangePicker() async {
      final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020, 1, 1),
        lastDate: DateTime(2030, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'Done',
      );

      if (result != null) {
        selectedDateRange.value = result;
      }
    }

    return Column(
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
                          ref
                              .read(reportNotifierProvider.notifier)
                              .setSearchTerm(value);
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _showDateRangePicker,
                    child: const Text('Select Date Range'),
                  ),
                  TextButton(
                    onPressed: () {
                      // ref
                      //     .read(ReportSearchControllerProvider.notifier)
                      //     .searchReports(textFieldController.text);
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            )),
        const Divider(height: 1),
        Expanded(
          flex: 8,
          child: searchResults.when(
            data: (reportState) {
              final tableColumns = DataTableHelper.buildColumns<Report>(
                  forPrint: true, blacklist: blackList);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: tableColumns,
                          rows: DataTableHelper.buildRows<Report>(
                              reportState.reports as List<Report?>?),
                        )),
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
            error: (_, __) =>
                const Center(child: Text('An error occurred while searching.')),
          ),
        ),
      ],
    );
  }
}
