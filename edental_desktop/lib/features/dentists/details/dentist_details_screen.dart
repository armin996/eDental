import 'dart:io';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../common/models/dentist.dart';
import '../provider/dentistProvider.dart'; // Import the Dentist model

class DentistDetailScreen extends HookConsumerWidget {
  final int? _id; // Make _id nullable to support both create and update

  DentistDetailScreen(this._id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dentist = ref.watch(dentistNotifierProvider);
    final formKey = GlobalKey<FormBuilderState>();
    var selectedImage = useState<File?>(null);
    var isCreateMode = useState(_id == null);

    useEffect(() {
      if (!isCreateMode.value) {
        ref.read(dentistNotifierProvider.notifier).fetchDentistById(_id!);
      }
      return null;
    }, const []);

    Future<void> _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = File(image.path);
        if (dentist.value!.selectedDentist != null) {
          dentist.value!.selectedDentist!.image =
              await selectedImage.value!.readAsBytes();
        }
      }
    }

    return dentist.when(
        data: (dentistState) {
          if (dentistState.selectedDentist == null && !isCreateMode.value)
            return const Text("No data");
          final dentistData = dentistState.selectedDentist ?? Dentist();
          return Scaffold(
            appBar: AppBar(
                title: Text(
                    isCreateMode.value ? "Create Dentist" : "Dentist details")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                initialValue: {
                  'firstName': isCreateMode.value ? '' : dentistData.firstName,
                  'lastName': isCreateMode.value ? '' : dentistData.lastName,
                  'phone': isCreateMode.value ? '' : dentistData.phone,
                  'email': isCreateMode.value ? '' : dentistData.email,
                  'address': isCreateMode.value ? '' : dentistData.address,
                  'birthDate': isCreateMode.value
                      ? DateTime.now()
                      : dentistData.birthDate!,
                  'description':
                      isCreateMode.value ? '' : dentistData.description,
                  'active': isCreateMode.value ? false : dentistData.active,
                  'fullName': isCreateMode.value ? '' : dentistData.fullName,
                },
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: dentistData.image != null &&
                              dentistData.image!.isNotEmpty
                          ? Image.memory(
                              dentistData.image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : const Text('Tap to select an image'),
                    ),
                    FormBuilderTextField(
                      name: 'firstName',
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(2),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'lastName',
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(2),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'phone',
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'address',
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'birthDate',
                      inputType: InputType.date,
                      decoration: InputDecoration(labelText: 'Birth Date'),
                      initialTime: const TimeOfDay(hour: 10, minute: 0),
                    ),
                    // FormBuilderTextField(
                    //   name: 'dentistOfficeId',
                    //   decoration:
                    //       InputDecoration(labelText: 'Dentist Office ID'),
                    //   validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.required(),
                    //     FormBuilderValidators.numeric(),
                    //   ]),
                    // ),
                    FormBuilderTextField(
                      name: 'description',
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderSwitch(
                      name: 'active',
                      title: Text('Active'),
                      initialValue:
                          isCreateMode.value ? false : dentistData.active,
                    ),
                    // FormBuilderTextField(
                    //   name: 'fullName',
                    //   decoration: InputDecoration(labelText: 'Full Name'),
                    //   validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.required(),
                    //   ]),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          final dentistToSave = Dentist(
                            id: isCreateMode.value ? 0 : dentistData.id,
                            firstName: formKey.currentState!.value['firstName'],
                            lastName: formKey.currentState!.value['lastName'],
                            phone: formKey.currentState!.value['phone'],
                            email: formKey.currentState!.value['email'],
                            address: formKey.currentState!.value['address'],
                            birthDate: formKey.currentState!.value['birthDate'],
                            dentistOfficeId: 1,
                            image: selectedImage.value != null
                                ? selectedImage.value?.readAsBytesSync()
                                : dentistData.image,
                            description:
                                formKey.currentState!.value['description'],
                            active:
                                formKey.currentState!.value['active'] == 'true',
                          );
                          if (isCreateMode.value) {
                            ref
                                .read(dentistNotifierProvider.notifier)
                                .createDentist(dentistToSave);
                          } else {
                            ref
                                .read(dentistNotifierProvider.notifier)
                                .updateDentist(dentistToSave);
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
        error: (error, __) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
