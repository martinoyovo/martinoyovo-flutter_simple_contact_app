import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_contact_app/models/contact.dart';
import 'package:stacked/stacked.dart';

class ContactService with ListenableServiceMixin {
  static String contactsBoxName = "contacts";

  final _contacts = ReactiveValue<List<Contact>>([]);
  List<Contact> get contacts => _contacts.value;

  final _filteredContacts = ReactiveValue<List<Contact>>([]);

  List<Contact> get filteredContacts => _filteredContacts.value;

  final _groups = ReactiveValue<List<Group>>([]);
  List<Group> get groups => _groups.value;

  final _selectedContact = ReactiveValue<Contact?>(null);
  Contact get selectedContact => _selectedContact.value!;

  final _relationship = ReactiveValue<Relationship?>(null);
  Relationship? get relationship => _relationship.value;

  final _uploadedImage = ReactiveValue<String>('');
  String get uploadedImage => _uploadedImage.value;

  Future<void> _init() async {
    await _loadContactsFromHive();
  }

  Future<void> _loadContactsFromHive() async {
    _contacts.value = await Hive.box(contactsBoxName)
        .get(contactsBoxName, defaultValue: [])
        .cast<Contact>();
    _filteredContacts.value = _contacts.value;
  }

  ContactService() {
    _init();
    listenToReactiveValues([
      _contacts,
      _groups,
      _relationship
    ]);
  }

  void addContact({
    String? firstname,
    String? lastname,
    String? nickname,
    String? phone,
    String? email,
    String? notes}) {
    final newContact = Contact(
      id: _contacts.value.length,
      firstname: firstname,
      lastname: lastname,
      nickname: nickname,
      phone: phone,
      email: email,
      notes: notes,
      groups: _groups.value,
      relationship: _relationship.value
    );

    _contacts.value.insert(0, newContact);

    _saveToHive();

    notifyListeners();
  }

  void deleteContact() {
    if(_selectedContact.value != null) {
      _contacts.value
        .removeWhere((contact) => contact.id == _selectedContact.value!.id);

      _saveToHive();
    }
    notifyListeners();
  }

  void updateContact({
    String? firstname,
    String? lastname,
    String? nickname,
    String? phone,
    String? email,
    String? notes}) {
    final oldContact = _selectedContact.value!;
    _selectedContact.value = Contact(
      id: oldContact.id,
      firstname: firstname ?? oldContact.firstname,
      lastname: lastname ?? oldContact.lastname,
      nickname: nickname ?? oldContact.nickname,
      phone: phone ?? oldContact.phone,
      email: email ?? oldContact.email,
      notes: notes ?? oldContact.notes,
      groups: _groups.value,
      relationship: _relationship.value
    );

    _contacts.value[_selectedContact.value!.id] = _selectedContact.value!;
    _saveToHive();

    notifyListeners();
  }

  void updateGroup(Group group) {
    if(_groups.value.contains(group)) {
      _groups.value.remove(group);
    }
    else {
      _groups.value.add(group);
    }
    notifyListeners();
  }

  void updateRelationship(Relationship relationship) {
    _relationship.value = relationship;
    notifyListeners();
  }

  void setContact(Contact contact) {
    _groups.value = contact.groups ?? [];
    _relationship.value = contact.relationship;
    _selectedContact.value = contact;
    notifyListeners();
  }

  void searchContact(String query) {
    final lowerCaseQuery = query.toLowerCase();
    if(lowerCaseQuery.isEmpty) {
      _filteredContacts.value = _contacts.value;
    }
    else {
      _filteredContacts.value = _contacts.value.where((c) =>
        '${c.firstname} ${c.lastname}'.toLowerCase().contains(lowerCaseQuery))
        .toList();
    }
    notifyListeners();
  }

  void _saveToHive() {
    Hive.box(contactsBoxName)
      .put(contactsBoxName, _contacts.value);
  }

  void setImage(String image) {
    _uploadedImage.value = image;
    notifyListeners();
  }

  void clearImage() {
    _uploadedImage.value = '';
    notifyListeners();
  }
}