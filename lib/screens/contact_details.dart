import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_colors.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/utils/extensions.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
import 'package:simple_contact_app/widgets/dialog_helper.dart';
import 'package:simple_contact_app/widgets/forms/update_contact_form.dart';
import 'package:stacked/stacked.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
        viewModelBuilder: () => ContactViewModel(),
        builder: (context, viewModel, _) {
          final contact = viewModel.selectedContact;
          return Scaffold(
            appBar: AppBar(
                title: const Text('Détails du contact',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            bottomSheet: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bottomButton(
                      icon: CupertinoIcons.delete,
                      iconColor: AppColors.redColor,
                      text: "Supprimer",
                      onTap: () {
                        viewModel.deleteContact();
                        context.pop();
                      }
                  ),
                  const Gap(AppDimens.margin5),

                  _bottomButton(
                      icon: CupertinoIcons.pencil_outline,
                      text: "Modifier",
                      onTap: () {
                        DialogHelper().showBottomSheet(
                          context: context,
                          child: UpdateContactForm(viewModel)
                        );
                      }
                  ),
                ],
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.margin2_5),
              children: [
                const Gap(AppDimens.margin4),
                Row(
                  children: [
                    Container(
                      height: AppDimens.bigAvatarSize,
                      width: AppDimens.bigAvatarSize,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neutral100
                      ),
                      child: Center(
                          child: Text(
                              contact.firstname == null ? "" : contact.firstname![0],
                              style: AppStyles.avatarTextStyle
                          )
                      ),
                    ),
                  ],
                ),
                const Gap(AppDimens.margin2),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text("${contact.firstname ?? ''} ${contact.lastname ?? ''}",
                        style: AppStyles.avatarTextStyle)
                ),

                const Gap(AppDimens.margin4),

                if(contact.phone != null) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(CupertinoIcons.phone_circle, size: AppDimens.iconSize,),
                      title: Text(contact.phone ?? '', style: AppStyles.bodyStyle,)
                  ),
                  const Gap(AppDimens.margin2),
                ],

                if(contact.nickname != null) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Surnom', style: AppStyles.subtitleStyle,),
                      subtitle: Text("@${contact.nickname}", style: AppStyles.bodyStyle,)
                  ),
                  const Gap(AppDimens.margin2),
                ],

                if(contact.email != null) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Email', style: AppStyles.subtitleStyle,),
                      subtitle: Text(contact.email ?? "", style: AppStyles.bodyStyle,)
                  ),
                  const Gap(AppDimens.margin2),
                ],

                if(contact.groups != null && contact.groups!.isNotEmpty) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Groupes', style: AppStyles.subtitleStyle,),
                      subtitle: Text(contact.groups!.toStringList().join(', ')
                          .capitalizeFirstLetter(),
                        style: AppStyles.bodyStyle,
                      )
                  ),
                  const Gap(AppDimens.margin2),
                ],

                if(contact.relationship != null) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Relation', style: AppStyles.subtitleStyle,),
                      subtitle: Text(contact.relationship!.name
                          .capitalizeFirstLetter(),
                        style: AppStyles.bodyStyle,
                      )
                  ),
                  const Gap(AppDimens.margin2),
                ],

                if(contact.notes != null) ...[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Notes', style: AppStyles.subtitleStyle,),
                      subtitle: Text(contact.notes ?? "", style: AppStyles.bodyStyle,)
                  ),
                  const Gap(AppDimens.margin2),
                ],

                const Gap(AppDimens.margin10)
              ],
            ),
          );
        }
    );
  }
}

Widget _bottomButton({
  required IconData icon,
  Color? iconColor,
  required String text,
  required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor,),
        const Gap(AppDimens.margin1),
        Text(text, style: AppStyles.subtitleStyle.copyWith(color: AppColors.neutral500),)
      ],
    ),
  );
}
