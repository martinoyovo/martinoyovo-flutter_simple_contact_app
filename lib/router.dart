import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_contact_app/screens/contact_details.dart';
import 'package:simple_contact_app/screens/contact_list.dart';
import 'package:simple_contact_app/widgets/forms/add_contact_form.dart';

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ContactList(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) {
        return const ContactDetails();
      },
    ),GoRoute(
      path: '/addContact',
      builder: (context, state) {
        return const AddContactForm();
      },
    ),
  ],
);