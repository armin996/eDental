import 'dart:io';

import 'package:edental_desktop/features/dentists/provider/dentistProvider.dart';
import 'package:edental_desktop/features/treatments/providers/treatmentProvider.dart';
import 'package:edental_desktop/features/users/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../common/models/appointment.dart';
import '../../../common/models/treatment.dart'; // Assuming you have a Treatment model
import '../../../common/models/dentist.dart'; // Assuming you have a Dentist model
import '../../../common/models/user.dart'; // Assuming you have a User model
import '../providers/appointmentProvider.dart';

class AppointmentDetailScreen extends HookConsumerWidget {
  final int? _id;
  AppointmentDetailScreen(this._id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointment = ref.watch(appointmentNotifierProvider);
    final treatmentProvider = ref.watch(treatmentNotifierProvider);
    final dentistProvider = ref.watch(dentistNotifierProvider);
    final userProvider = ref.watch(userNotifierProvider);
    final formKey = GlobalKey<FormBuilderState>();
    var isCreateMode = useState(_id == null);
    useEffect(() {
      if (!isCreateMode.value) {
        ref
            .read(appointmentNotifierProvider.notifier)
            .fetchAppointmentById(_id!);
      }
      // Fetch the lists
      ref.read(treatmentNotifierProvider.notifier).loadTreatments();
      ref.read(dentistNotifierProvider.notifier).loadDentists();
      ref.read(userNotifierProvider.notifier).loadUsers();
      return null;
    }, const []);

    var treatments = useState<int?>(null);
    var dentists = useState<int?>(null);
    var users = useState<int?>(null);

    return appointment.when(
        data: (appointmentState) {
          if (appointmentState.selectedAppointment == null &&
              !isCreateMode.value) return const Text("No data");
          final appointmentData =
              appointmentState.selectedAppointment ?? Appointment.empty();
          return Scaffold(
            appBar: AppBar(
                title: Text(isCreateMode.value
                    ? "Create Appointment"
                    : "Appointment details")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                initialValue: {
                  'start': isCreateMode.value
                      ? DateTime.now()
                      : appointmentData.start!,
                  'end': isCreateMode.value
                      ? DateTime.now()
                      : appointmentData.end!,
                  'dentistId':
                      isCreateMode.value ? 0 : appointmentData.dentistId,
                  'treatmentId':
                      isCreateMode.value ? 0 : appointmentData.treatmentId,
                  'userId': isCreateMode.value ? 0 : appointmentData.userId
                },
                child: Column(
                  children: [
                    FormBuilderDateTimePicker(
                      name: 'start',
                      decoration:
                          const InputDecoration(labelText: 'Start Time'),
                      initialTime: const TimeOfDay(hour: 9, minute: 0),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'end',
                      decoration: const InputDecoration(labelText: 'End Time'),
                      initialTime: const TimeOfDay(hour: 10, minute: 0),
                    ),
                    treatmentProvider.when(
                        data: (data) => FormBuilderDropdown(
                              name: 'treatmentId',
                              initialValue: treatments.value,
                              onChanged: (value) {
                                treatments.value = value;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Select Treatment'),
                              items: data.treatments!.map((treatment) {
                                return DropdownMenuItem(
                                  value: treatment.id,
                                  child: Text(treatment.name ?? "Undefined"),
                                );
                              }).toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                        loading: () => CircularProgressIndicator(),
                        error: (e, stackTrace) =>
                            const Text("Can't load data")),
                    dentistProvider.when(
                        data: (data) => FormBuilderDropdown(
                              name: 'dentistId',
                              initialValue: dentists.value,
                              onChanged: (value) {
                                dentists.value = value;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Select Dentist'),
                              items: data.dentists!.map((dentist) {
                                return DropdownMenuItem(
                                  value: dentist.id,
                                  child: Text(dentist.fullName),
                                );
                              }).toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                        loading: () => CircularProgressIndicator(),
                        error: (e, stackTrace) =>
                            const Text("Can't load data")),
                    userProvider.when(
                        data: (data) => FormBuilderDropdown(
                              name: 'userId',
                              initialValue: users.value,
                              onChanged: (value) {
                                users.value = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Select User'),
                              items: data.users!.map((user) {
                                return DropdownMenuItem(
                                  value: user.id,
                                  child: Text(user.fullName),
                                );
                              }).toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, stackTrace) => const Text("")),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          final appointmentToSave = Appointment(
                            id: isCreateMode.value ? 0 : appointmentData.id,
                            start: formKey.currentState!.value['start'],
                            end: formKey.currentState!.value['end'],
                            dentistId: formKey.currentState!.value['dentistId'],
                            treatmentId:
                                formKey.currentState!.value['treatmentId'],
                            userId: formKey.currentState!.value['userId'],
                            clientFullName:
                                formKey.currentState!.value['clientFullName'] ??
                                    "",
                            dentistFullName: formKey
                                    .currentState!.value['dentistFullName'] ??
                                "",
                            treatmentName:
                                formKey.currentState!.value['treatmentName'] ??
                                    "",
                          );
                          if (isCreateMode.value) {
                            ref
                                .read(appointmentNotifierProvider.notifier)
                                .createAppointment(appointmentToSave);
                          } else {
                            ref
                                .read(appointmentNotifierProvider.notifier)
                                .updateAppointment(appointmentToSave);
                          }
                        }
                      },
                      child: Text(isCreateMode.value ? 'Create' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, __) => const Text("Error happened"),
        loading: () => const CircularProgressIndicator());
  }
}
