import 'dart:io';

class ContactModel {
  final String? name;
  final File? image;
  final String? number;
  final String? chat;
  final String? date;
  final String? time;

  ContactModel(
      {required this.name,
      required this.image,
      required this.number,
      required this.chat,
      required this.date,
      required this.time});
}
