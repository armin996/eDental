import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:edental_desktop/features/treatments/providers/treatmentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/models/treatment.dart';

class TreatmentDetailScreen extends HookConsumerWidget {
  final int? _id;
  TreatmentDetailScreen(this._id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treatment = ref.watch(treatmentNotifierProvider);
    final formKey = GlobalKey<FormBuilderState>();
    var selectedImage = useState<File?>(null);
    var isCreateMode = useState(_id == null); // Determine if it's create mode

    useEffect(() {
      if (!isCreateMode.value) {
        ref.read(treatmentNotifierProvider.notifier).fetchTreatmentById(_id!);
      }
      return null;
    }, const []);

    Future<void> _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    }

    return treatment.when(
        data: (treatmentState) {
          if (treatmentState.treatment == null && !isCreateMode.value)
            return const Text("No data");
          final treatmentData = treatmentState.treatment ??
              Treatment(); // Assuming Treatment has an empty constructor
          return Scaffold(
            appBar: AppBar(
                title: Text(isCreateMode.value
                    ? "Create Treatment"
                    : "Treatment details")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                initialValue: {
                  'name': isCreateMode.value ? '' : treatmentData.name,
                  'price':
                      isCreateMode.value ? '0' : treatmentData.price.toString(),
                  'timeRequiredInMinutes': isCreateMode.value
                      ? '0'
                      : treatmentData.timeRequiredInMinutes.toString(),
                },
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: _pickImage,
                    //   child: treatmentData.image != null
                    //       ? Image.memory(
                    //           treatmentData.image!.asUint8List(),
                    //           width: 100, // Adjust the size as needed
                    //           height: 100, // Adjust the size as needed
                    //           fit: BoxFit.cover,
                    //         )
                    //       : const Text('Tap to select an image'),
                    // ),
                    FormBuilderTextField(
                      name: 'name',
                      decoration:
                          const InputDecoration(labelText: 'Treatment Name'),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: const InputDecoration(labelText: 'Price'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'timeRequiredInMinutes',
                      decoration: const InputDecoration(
                          labelText: 'Time Required (minutes)'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          final treatmentToSave = Treatment(
                            id: isCreateMode.value ? 0 : treatmentData.id,
                            name: formKey.currentState!.value['name'],
                            price: double.parse(
                                formKey.currentState!.value['price']),
                            timeRequiredInMinutes: int.parse(formKey
                                .currentState!.value['timeRequiredInMinutes']),
                            image:
                                selectedImage.value?.readAsBytesSync().buffer,
                          );
                          if (isCreateMode.value) {
                            ref
                                .read(treatmentNotifierProvider.notifier)
                                .createTreatment(treatmentToSave);
                          } else {
                            ref
                                .read(treatmentNotifierProvider.notifier)
                                .updateTreatment(treatmentToSave);
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
