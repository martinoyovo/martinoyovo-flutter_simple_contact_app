import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';
import 'package:simple_contact_app/constants/app_styles.dart';
import 'package:simple_contact_app/view_models/contact_view_model.dart';
import 'package:simple_contact_app/widgets/contact_card.dart';
import 'package:simple_contact_app/widgets/contact_outlined_button.dart';
import 'package:simple_contact_app/widgets/default_text_field.dart';
import 'package:simple_contact_app/widgets/dialog_helper.dart';
import 'package:simple_contact_app/widgets/forms/update_contact_form.dart';
import 'package:simple_contact_app/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class ContactList extends StatelessWidget {
  static const String screenName = 'contactList';

  ContactList({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
      viewModelBuilder: () => ContactViewModel(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contacts',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Builder(builder: (_) {
              if (viewModel.contacts.isEmpty) {
                return const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.phone_down_circle_fill,
                          size: AppDimens.iconSize),
                      Gap(AppDimens.margin2),
                      Text(
                        'Aucun contact.\nCliquer + pour ajouter.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.margin2),
                    child: DefaultTextField(
                      controller: searchController,
                      onChanged: viewModel.searchContact,
                      prefixIcon: const Icon(CupertinoIcons.search),
                      hint: viewModel.hintSearch,
                    ),
                  ),
                  const Gap(AppDimens.margin2_5),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.margin2),
                      itemCount: viewModel.filteredContacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = viewModel.filteredContacts[index];
                        return Dismissible(
                          background: Container(
                            color: Colors.grey.shade300,
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: AppDimens.margin1_5,
                                ),
                                child: Icon(CupertinoIcons.archivebox_fill),
                              ),
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              bool delete = true;
                              viewModel.setContact(contact);
                              viewModel.rebuildUi();
                              viewModel.deleteContact();

                              final snackbarController =
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    'Contact "${contact.firstname} ${contact.lastname}" supprimé avec succès.',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                              await snackbarController.closed;
                              return delete;
                            }
                            return false;
                          },
                          key: Key(contact.id.toString()),
                          child: ContactCard(
                            contact: contact,
                            onTap: () {
                              viewModel.setContact(contact);
                              context.push('/contact');
                            },
                            onTapTrailing: () {
                              DialogHelper().showBottomSheet(
                                  context: context,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            height: 5,
                                            width: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Gap(AppDimens.margin2),
                                        SizedBox(
                                            width: double.infinity,
                                            child: PrimaryButton(
                                              label: 'Modifier',
                                              onPressed: () {
                                                context.pop();
                                                viewModel.setContact(contact);
                                                //context.push('/contact');
                                                DialogHelper().showBottomSheet(
                                                    context: context,
                                                    child: UpdateContactForm(
                                                        viewModel));
                                              },
                                            )),
                                        const Gap(AppDimens.margin2),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ContactOutlinedButton(
                                            label: 'Supprimer',
                                            onPressed: () {
                                              viewModel.setContact(contact);
                                              viewModel.deleteContact();
                                              context.pop();
                                            },
                                          ),
                                        ),
                                        const Gap(AppDimens.margin2),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(AppDimens.margin3);
                      },
                    ),
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    style: AppStyles.primaryButtonStyle,
                    onPressed: () {
                      context.push('/addContact');
                      /*DialogHelper().showBottomSheet(
                          context: context, child: const AddContactForm());*/
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        Gap(20),
                        Text(
                          'Nouveau contact',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
