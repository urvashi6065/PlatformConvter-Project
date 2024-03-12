import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'Provider class.dart';
import 'model_Class.dart';

class addContact extends StatefulWidget {
  const addContact({Key? key}) : super(key: key);

  @override
  State<addContact> createState() => _addContactState();
}
class _addContactState extends State<addContact> {

  final formkey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController chatController=TextEditingController();

  String? formatedate;
  String? formateTime;

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return Consumer<ProviderClass>(builder: (context, imageVar, child) {
            return AlertDialog(
              title: Text('Select From'),
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        imageVar.pickImageFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.camera_on_rectangle),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Camera'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        imageVar.pickImageFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Gallery')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }


  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ProviderClass>(context,listen: true);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showDialogBox();
                },
                child: (providerVar.fileImage != null)
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(providerVar.fileImage!),
                      )
                    : CircleAvatar(
                        radius: 70,
                        child: Icon(CupertinoIcons.camera_on_rectangle),
                      ),
              ),

              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    label: Text('Full Name'),
                    hintText: "Full Name",
                    prefixIcon: Icon(CupertinoIcons.person),
                    border: OutlineInputBorder()),
                controller: nameController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Your Name";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    label: Text('Phone Number'),
                    hintText: "Phone Number",
                    prefixIcon: Icon(Icons.call),
                    border: OutlineInputBorder()),
                controller: numberController,
                maxLength: 10,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Your Number";
                  }
                },
                keyboardType: TextInputType.number,
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
                controller: chatController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Your Chat";
                  }
                },
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
                  if(date!=null){
                    setState(() {
                      formatedate=DateFormat("dd-MM-yyyy").format(date!);
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 10,
                    ),
                    (formatedate!=null)?Text(formatedate!): Text('Pick Date'),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  var time=await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  final time1=MaterialLocalizations.of(context);
                  setState(() {
                    formateTime=time1.formatTimeOfDay(time!);
                  });
                },
                child: Row(
                  children: [
                    Icon(CupertinoIcons.time),
                    SizedBox(
                      width: 10,
                    ),
                    (formateTime!=null)?Text(formateTime!): Text('Pick Time')
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      if(providerVar.fileImage==null){
                        Fluttertoast.showToast(msg: 'Add Photo');
                      }else if(formatedate==null){
                          Fluttertoast.showToast(msg: 'Add Date');
                      }else if(formateTime==null){
                          Fluttertoast.showToast(msg: 'Add Time');
                      }else{
                        ContactModel contact=ContactModel(name: nameController.text, image: providerVar.fileImage, number: numberController.text, chat: chatController.text, date: formatedate, time: formateTime);
                            providerVar.addListData(contact);
                            nameController.clear();
                            numberController.clear();
                            chatController.clear();
                            formatedate=null;
                            formateTime=null;
                            providerVar.fileImage=null;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save Successfullyy')));}
                    }
                  },
                  child: Text('save'))
            ],
          ),
        ),
      ),
    );
  }
}
