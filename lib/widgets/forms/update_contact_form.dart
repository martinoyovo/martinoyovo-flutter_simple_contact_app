import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_colors.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/models/contact.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
import 'package:simple_contact_app/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

import '../default_text_field.dart';

class UpdateContactForm extends StatefulWidget {
  final ContactViewModel viewModel;
  const UpdateContactForm(
    this.viewModel, {
    super.key,
  });

  @override
  State<UpdateContactForm> createState() => _UpdateContactFormState();
}

class _UpdateContactFormState extends State<UpdateContactForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController nickNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController notesController;

  @override
  void initState() {
    firstNameController =
        TextEditingController(text: widget.viewModel.selectedContact.firstname);
    lastNameController =
        TextEditingController(text: widget.viewModel.selectedContact.lastname);
    nickNameController =
        TextEditingController(text: widget.viewModel.selectedContact.nickname);
    emailController =
        TextEditingController(text: widget.viewModel.selectedContact.email);
    phoneController =
        TextEditingController(text: widget.viewModel.selectedContact.phone);
    notesController =
        TextEditingController(text: widget.viewModel.selectedContact.notes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppDimens.margin1_5, bottom: AppDimens.margin3),
            child: Row(
              children: [
                Text(
                  'Mettre à jour le contact',
                  style: AppStyles.titleStyle,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(CupertinoIcons.clear_circled_solid),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        ViewModelBuilder<ContactViewModel>.reactive(
            viewModelBuilder: () => widget.viewModel,
            disposeViewModel: false,
            builder: (context, viewModel, _) {
              return AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppDimens.margin6_5),
                    DefaultTextField(
                      controller: firstNameController,
                      onChanged: viewModel.updateFirstName,
                      hint: viewModel.hintFirstName,
                    ),
                    const Gap(AppDimens.margin2),
                    DefaultTextField(
                      controller: lastNameController,
                      onChanged: viewModel.updateLastName,
                      hint: viewModel.hintLastName,
                    ),
                    const Gap(AppDimens.margin2),
                    DefaultTextField(
                      controller: nickNameController,
                      onChanged: viewModel.updateNickName,
                      hint: viewModel.hintNickName,
                    ),
                    const Gap(AppDimens.margin2),
                    DefaultTextField(
                      controller: emailController,
                      onChanged: viewModel.updateEmail,
                      hint: viewModel.hintEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(AppDimens.margin2),
                    DefaultTextField(
                      controller: phoneController,
                      onChanged: viewModel.updatePhone,
                      hint: viewModel.hintPhone,
                      keyboardType: TextInputType.phone,
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
                    Row(
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
                                Text(group.inFrench),
                                const Gap(AppDimens.margin2)
                              ],
                            )),
                      ],
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
                            hint: const Text("Sélectionner"),
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
                        label: 'Mettre à jour',
                        onPressed: () {
                          viewModel.updateContact();
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
