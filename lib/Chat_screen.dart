import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'Add_contact.dart';
import 'Provider class.dart';
import 'model_Class.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({
    key,
  });

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController numberController1 = TextEditingController();
  TextEditingController chatController1 = TextEditingController();
  File? image1;
  int index1 = 0;
  String? formateDate;
  String? formatTime;

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Edit Data',
                style: TextStyle(fontSize: 20),
              ),
              content: SingleChildScrollView(
                child: Container(
                  height: 510,
                  width: 700,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(image1!),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text('Full Name'),
                            hintText: "Full Name",
                            prefixIcon: Icon(CupertinoIcons.person),
                            border: OutlineInputBorder()),
                        controller: nameController1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        decoration: InputDecoration(
                            label: Text("Phone Number"),
                            hintText: "Phone Number",
                            prefixIcon: Icon(Icons.call),
                            border: OutlineInputBorder()),
                        controller: numberController1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text('Chat Conversation'),
                            hintText: "Chat Conversation",
                            prefixIcon: Icon(Icons.chat_outlined),
                            border: OutlineInputBorder()),
                        controller: chatController1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1996),
                              lastDate: DateTime.now(),
                              initialDate: DateTime.now());
                          if (date != null) {
                            print(date);
                            setState(() {
                              formateDate =
                                  DateFormat("dd-MM-yyyy").format(date!);
                              print(formateDate);
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 10,
                            ),
                            Text(formateDate!),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer<ProviderClass>(
                          builder: (context, timeConsumerVar, child) {
                        return InkWell(
                          onTap: () async {
                            var time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            final time1 = MaterialLocalizations.of(context);
                            setState(() {
                               formatTime=time1.formatTimeOfDay(time!);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.time),
                              SizedBox(
                                width: 10,
                              ),
                               Text(formatTime!),
                            ],
                          ),
                        );
                      }),
                      Consumer<ProviderClass>(
                          builder: (context, ConsumerVar, child) {
                        return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                ContactModel contact=ContactModel(name: nameController1.text, image: image1, number: numberController1.text, chat: chatController1.text, date:  formateDate, time: formatTime);
                                ConsumerVar.upDateListData(index1, contact);
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('Edit'));
                      })
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ProviderClass>(context, listen: true);
    // nameController1.text=widget.name.toString();
    return (providerVar.contactList.isEmpty)
        ? Center(child: Text('No Any Chat Yet...'))
        : ListView.builder(
            itemCount: providerVar.contactList.length,
            itemBuilder: (context, int index) {
              nameController1.text = providerVar.contactList[index].name!;
              numberController1.text = providerVar.contactList[index].number!;
              chatController1.text = providerVar.contactList[index].chat!;
              image1 = providerVar.contactList[index].image;
              formateDate = providerVar.contactList[index].date!;
              formatTime=providerVar.contactList[index].time!;
              index1 = index;
              return ListTile(
                onTap: () {
                  openBottomsheet(
                      providerVar.contactList[index].image,
                      providerVar.contactList[index].name,
                      providerVar.contactList[index].chat,
                      index);
                },
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      FileImage(providerVar.contactList[index].image!),
                ),
                title: Text(providerVar.contactList[index].name!),
                subtitle: Text(providerVar.contactList[index].chat!),
                trailing: Container(
                  // color: Colors.red,
                  width: 120,
                  height: 40,
                  child: Column(
                    children: [
                      Text(
                        providerVar.contactList[index].date!,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(providerVar.contactList[index].time!),
                    ],
                  ),
                ),
              );
            });
  }

  openBottomsheet(image8, name, chat, Index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(image8),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(chat),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showDialogBox();
                            });
                          },
                          icon: Icon(Icons.edit)),
                      Consumer<ProviderClass>(
                          builder: (context, delateConsumerVar, child) {
                        return IconButton(
                            onPressed: () {
                              delateConsumerVar.delateListData(Index);
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.delete));
                      }),
                    ],
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'))
                ],
              ),
            ),
          );
        });
  }
}
