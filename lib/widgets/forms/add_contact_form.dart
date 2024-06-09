import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
import 'package:simple_contact_app/widgets/contact_outlined_button.dart';
import 'package:simple_contact_app/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

import '../default_text_field.dart';

class AddContactForm extends StatefulWidget {
  static const String screenName = 'addContact';

  const AddContactForm({super.key});

  @override
  State<AddContactForm> createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ajouter un contact',
          style: AppStyles.titleStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.margin2),
        child: ViewModelBuilder<ContactViewModel>.reactive(
          viewModelBuilder: () => ContactViewModel(),
          /*onViewModelReady:(viewModel) {
            viewModel.cachedProfileImage
          },*/
          disposeViewModel: false,
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppDimens.margin1),
                      Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Colors.grey, width: 1.5),
                          ),
                          child: viewModel.cachedProfileImage.isEmpty
                              ? Icon(
                            Icons.person_2_rounded,
                            color: Colors.grey.shade400,
                            size: 100,
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(viewModel.cachedProfileImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Gap(AppDimens.margin2),
                      Center(
                        child: Transform.scale(
                          scale: 0.85,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ContactOutlinedButton(
                              label: 'Ajouter une image',
                              onPressed: viewModel.uploadImage,
                            ),
                          ),
                        ),
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: firstNameController,
                        onChanged: viewModel.updateFirstName,
                        hint: viewModel.hintFirstName,
                        validator: (v) => viewModel.validateFirstname(v),
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: lastNameController,
                        onChanged: viewModel.updateLastName,
                        hint: viewModel.hintLastName,
                        validator: (v) => viewModel.validateLastname(v),
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: phoneController,
                        onChanged: viewModel.updatePhone,
                        hint: viewModel.hintPhone,
                        keyboardType: TextInputType.phone,
                        validator: (v) => viewModel.validatePhone(v),
                      ),
                      const Gap(AppDimens.margin3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: ContactOutlinedButton(
                              label: 'Annuler',
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: PrimaryButton(
                              label: 'Enregistrer',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.addContact();
                                  context.pop();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      ),
    );
  }
}
