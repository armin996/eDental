import 'dart:io';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:edental_desktop/features/users/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/models/gender.dart';
import '../../../common/models/role.dart';
import '../../../common/models/user.dart';

class UserDetailScreen extends HookConsumerWidget {
  final int? _id; // Make _id nullable to support both create and update

  UserDetailScreen(this._id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
    final formKey = GlobalKey<FormBuilderState>();
    var selectedImage = useState<File?>(null);
    var isCreateMode = useState(_id == null); // Determine if it's create mode

    useEffect(() {
      if (!isCreateMode.value) {
        ref.read(userNotifierProvider.notifier).fetchUserById(_id!);
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

    return user.when(
        data: (userState) {
          if (userState.selectedUser == null && !isCreateMode.value)
            return const Text("No data");
          final userData = userState.selectedUser ??
              User(); // Assuming User has an empty constructor
          return Scaffold(
            appBar: AppBar(
                title:
                    Text(isCreateMode.value ? "Create User" : "User details")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                initialValue: {
                  'firstName': isCreateMode.value ? '' : userData.firstName,
                  'lastName': isCreateMode.value ? '' : userData.lastName,
                  'username': isCreateMode.value ? '' : userData.username,
                  'email': isCreateMode.value ? '' : userData.email,
                  'address': isCreateMode.value ? '' : userData.address,
                  'phone': isCreateMode.value ? '' : userData.phone,
                  'gender': isCreateMode.value
                      ? Gender.values.first.toString().split(".").last
                      : userData.gender.toString().split(".").last,
                  'role': isCreateMode.value
                      ? Role.values.first.toString().split(".").last
                      : userData.role.toString().split(".").last,
                  "notification": isCreateMode.value
                      ? true
                      : userData.isNotificationEnabled,
                },
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child:
                          userData.image != null && userData.image!.isNotEmpty
                              ? Image.memory(
                                  userData.image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : const Text('Tap to select an image'),
                    ),
                    FormBuilderTextField(
                      name: 'firstName',
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'lastName',
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'username',
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'address',
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'phone',
                      decoration: const InputDecoration(
                          labelText: 'Phone', hintText: 'Enter phone number'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.minLength(9),
                      ]),
                    ),
                    FormBuilderField<Gender>(
                        name: 'gender',
                        initialValue:
                            userState.selectedUser!.gender, // Default value
                        builder: (field) {
                          return SwitchListTile(
                              title: Text(field.value == Gender.Male
                                  ? 'Male'
                                  : 'Female'),
                              value: field.value == Gender.Male,
                              onChanged: (bool? value) {
                                field.didChange(value == true
                                    ? Gender.Male
                                    : Gender.Female);
                              });
                        }),
                    FormBuilderField<Role>(
                        name: 'role',
                        initialValue: Role.Client, // Default value
                        builder: (field) {
                          return SwitchListTile(
                              title: Text(field.value == Role.Client
                                  ? 'User'
                                  : 'Admin'),
                              value: field.value == Role.Client,
                              onChanged: (bool? value) {
                                field.didChange(
                                    value == true ? Role.Client : Role.Admin);
                              });
                        }),
                    FormBuilderField<bool>(
                        name: 'notification',
                        initialValue: true, // Default value
                        builder: (field) {
                          return SwitchListTile(
                              title: Text(field.value! ? 'Yes' : 'No'),
                              value: field.value!,
                              onChanged: (value) {
                                field.didChange(value);
                              });
                        }),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(
                          hintText: 'Password', labelText: 'Password'),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(8, allowEmpty: true)
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'passwordConfirm',
                      decoration: const InputDecoration(
                          hintText: 'Password Confirm',
                          labelText: 'Password Confirm'),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(8, allowEmpty: true)
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            final userToSave = User(
                              id: isCreateMode.value ? 0 : userData.id,
                              firstName:
                                  formKey.currentState!.value['firstName'],
                              lastName: formKey.currentState!.value['lastName'],
                              username: formKey.currentState!.value['username'],
                              email: formKey.currentState!.value['email'],
                              address: formKey.currentState!.value['address'],
                              gender: Gender.values.firstWhere((e) =>
                                  e.toString().split(".").last ==
                                  formKey.currentState!.value['gender']),
                              role: Role.values.firstWhere((e) =>
                                  e.toString().split(".").last ==
                                  formKey.currentState!.value['role']),
                              phone: formKey.currentState!.value['phone'],
                              password: formKey.currentState!.value['password'],
                              passwordConfirm: formKey
                                  .currentState!.value['passwordConfirm'],
                              image: selectedImage.value?.readAsBytesSync(),
                              isNotificationEnabled:
                                  formKey.currentState!.value['notification'],
                            );
                            if (isCreateMode.value) {
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .createUser(userToSave);
                            } else {
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .updateUser(userToSave);
                            }
                          }
                        },
                        child: Text(isCreateMode.value ? 'Create' : 'Update'),
                      ),
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
