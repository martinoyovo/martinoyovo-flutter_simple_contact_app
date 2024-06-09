import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
import 'package:simple_contact_app/widgets/contact_outlined_button.dart';
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
  late TextEditingController phoneController;

  @override
  void initState() {
    firstNameController =
        TextEditingController(text: widget.viewModel.selectedContact.firstname);
    lastNameController =
        TextEditingController(text: widget.viewModel.selectedContact.lastname);
    phoneController =
        TextEditingController(text: widget.viewModel.selectedContact.phone);
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
            child: Center(
              child: Text(
                'Mettre à jour',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ViewModelBuilder<ContactViewModel>.reactive(
            viewModelBuilder: () => widget.viewModel,
            disposeViewModel: false,
            builder: (context, viewModel, _) {
              return AutofillGroup(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppDimens.margin6_5),
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
                          ) : ClipRRect(
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
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: lastNameController,
                        onChanged: viewModel.updateLastName,
                        hint: viewModel.hintLastName,
                      ),
                      const Gap(AppDimens.margin2),
                      DefaultTextField(
                        controller: phoneController,
                        onChanged: viewModel.updatePhone,
                        hint: viewModel.hintPhone,
                        keyboardType: TextInputType.phone,
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
                                viewModel.updateContact();
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(AppDimens.margin1),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
