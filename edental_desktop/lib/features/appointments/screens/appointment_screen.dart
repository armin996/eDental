import 'package:edental_desktop/common/helpers/dataTableBuilder.dart';
import 'package:edental_desktop/common/models/appointment.dart';
import 'package:edental_desktop/features/appointments/details/appointmentDetailScreen.dart';
import 'package:edental_desktop/features/appointments/providers/appointmentProvider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppointmentScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(appointmentNotifierProvider);

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

    void openAppointmentDetails(int? number) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => AppointmentDetailScreen(number)));
    }

    Future<void> resetSearchAndFetchAll() async {
      textFieldController.clear();
      ref
          .read(appointmentSearchControllerProvider.notifier)
          .setSearchTerm(textFieldController.text);
      await ref.read(appointmentNotifierProvider.notifier).loadAppointments();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetSearchAndFetchAll,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openAppointmentDetails(null),
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
                          controller: textFieldController,
                          onChanged: (value) {
                            ref
                                .read(appointmentSearchControllerProvider
                                    .notifier)
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
                      onPressed: () async {
                        Appointment request = Appointment.empty();
                        if (selectedDateRange.value != null) {
                          request.start = selectedDateRange.value?.start;
                          request.end = selectedDateRange.value?.end;
                        } else {
                          request.start = DateTime.now()
                              .subtract(const Duration(days: 1000));
                          request.end =
                              DateTime.now().add(const Duration(days: 1000));
                        }
                        request.searchTerm = textFieldController.text;
                        final list = await ref
                            .read(appointmentSearchControllerProvider.notifier)
                            .searchAppointments(request);

                        ref
                            .read(appointmentNotifierProvider.notifier)
                            .setAppointments(list);
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
              data: (appointments) {
                final tableColumns = DataTableHelper.buildColumns<Appointment>(
                    forPrint: true, blacklist: blackList);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: tableColumns,
                            rows: DataTableHelper.buildRows<Appointment>(
                                appointments.appointments,
                                blacklist: blackList,
                                onPress: openAppointmentDetails),
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
              error: (_, __) => const Center(
                  child: Text('An error occurred while searching.')),
            ),
          ),
        ],
      ),
    );
  }
}
