import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  int id;
  @HiveField(1)
  String? firstname;
  @HiveField(2)
  String? lastname;
  @HiveField(3)
  String? nickname;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? notes;
  @HiveField(7)
  List<Group>? groups;
  @HiveField(8)
  Relationship? relationship;

  Contact({
    required this.id,
    this.firstname,
    this.lastname,
    this.nickname,
    this.phone,
    this.email,
    this.notes,
    this.groups,
    this.relationship
  });
}

@HiveType(typeId: 1)
enum Group {
  @HiveField(0)
  family,
  @HiveField(1)
  friends,
  @HiveField(2)
  colleagues,
}

@HiveType(typeId: 2)
enum Relationship {
  @HiveField(0)
  friend,
  @HiveField(1)
  brother,
  @HiveField(2)
  sister,
  @HiveField(3)
  parent,
  @HiveField(4)
  spouse,
  @HiveField(5)
  other,
}

// Extension to add French translations for Group enum
extension GroupTranslations on Group {
  String get inFrench {
    switch (this) {
      case Group.family:
        return 'Famille';
      case Group.friends:
        return 'Amis';
      case Group.colleagues:
        return 'Collègues';
      default:
        return '';
    }
  }
}

// Extension to add French translations for Relationship enum
extension RelationshipTranslations on Relationship {
  String get inFrench {
    switch (this) {
      case Relationship.friend:
        return 'Ami(e)';
      case Relationship.brother:
        return 'Frère';
      case Relationship.sister:
        return 'Sœur';
      case Relationship.parent:
        return 'Parent';
      case Relationship.spouse:
        return 'Conjoint(e)';
      case Relationship.other:
        return 'Autre';
      default:
        return '';
    }
  }
}
