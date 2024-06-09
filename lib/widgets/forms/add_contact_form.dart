import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_colors.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/models/contact.dart';
import 'package:simple_contact_app/utils/extensions.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
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
  var nickNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var notesController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter un contact',
          style: AppStyles.titleStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear_circled_solid),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.margin2),
        child: ViewModelBuilder<ContactViewModel>.reactive(
            viewModelBuilder: () => ContactViewModel(),
            disposeViewModel: false,
            builder: (context, viewModel, _) {
              return Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppDimens.margin1),
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
                        controller: nickNameController,
                        onChanged: viewModel.updateNickName,
                        hint: viewModel.hintNickName,
                        //validator: (v) => viewModel.validateNickname(v),
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: emailController,
                        onChanged: viewModel.updateEmail,
                        hint: viewModel.hintEmail,
                        validator: (v) => viewModel.validateEmail(v),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: phoneController,
                        onChanged: viewModel.updatePhone,
                        hint: viewModel.hintPhone,
                        keyboardType: TextInputType.phone,
                        validator: (v) => viewModel.validatePhone(v),
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: notesController,
                        onChanged: viewModel.updateNotes,
                        hint: viewModel.hintNotes,
                        maxLines: 3,
                      ),
                      const Gap(AppDimens.margin2),
                      Text(
                        'Groupes',
                        style: AppStyles.mediumStyle,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...Group.values.map((group) => Row(
                                  children: [
                                    CupertinoCheckbox(
                                      value: viewModel.groups.contains(group),
                                      activeColor: AppColors.primary,
                                      onChanged: (value) {
                                        viewModel.updateGroup(group);
                                      },
                                    ),
                                    Text(
                                        group.inFrench.capitalizeFirstLetter()),
                                    const Gap(AppDimens.margin2)
                                  ],
                                )),
                          ],
                        ),
                      ),
                      const Gap(AppDimens.margin2),
                      Row(
                        children: [
                          Text(
                            'Relation',
                            style: AppStyles.mediumStyle,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.margin1_5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppDimens.margin1),
                              color: AppColors.neutral100,
                            ),
                            child: DropdownButton<Relationship>(
                              underline: const SizedBox(),
                              elevation: 2,
                              icon: const Icon(
                                  CupertinoIcons.chevron_up_chevron_down),
                              items: Relationship.values
                                  .map((Relationship relationship) {
                                return DropdownMenuItem<Relationship>(
                                  value: relationship,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: AppDimens.margin1_5),
                                    child: Text(relationship.inFrench),
                                  ),
                                );
                              }).toList(),
                              value: viewModel.relationship,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.margin1),
                              hint: const Text("Selectionner"),
                              onChanged: (value) {
                                viewModel.updateRelationship(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(AppDimens.margin3),
                      SizedBox(
                        width: double.infinity,
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
                ),
              );
            }),
      ),
    );
  }
}
