import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
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
                      controller: phoneController,
                      onChanged: viewModel.updatePhone,
                      hint: viewModel.hintPhone,
                      keyboardType: TextInputType.phone,
                    ),
                    const Gap(AppDimens.margin2),
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
