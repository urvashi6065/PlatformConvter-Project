import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Add_contact.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Provider%20class.dart';
import 'package:provider/provider.dart';

import 'model_Class.dart';

class chatScreenIOS extends StatefulWidget {
  const chatScreenIOS({Key? key}) : super(key: key);

  @override
  State<chatScreenIOS> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreenIOS> {
  TextEditingController nameControllerios=TextEditingController();
  TextEditingController numberControllerios=TextEditingController();
  TextEditingController chatControllerios=TextEditingController();
  int index1=0;
  File? image1;
  String? Date;
  String? formatTime;

  ActionSheet(image,name,chat,Index){
    showCupertinoModalPopup(context: context, builder: (context){
      return CupertinoActionSheet(
        title: Column(
          children: [
            CircleAvatar(radius: 60,backgroundImage: FileImage(image),),
            SizedBox(height: 5,),
            Text(name,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 4,
            ),
            Text(chat,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Consumer<ProviderClass>(
              builder: (context,consumerVar,child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(child: Icon(Icons.edit), onPressed: (){

                      showAlertBox();
                    }),
                    CupertinoButton(child: Icon(CupertinoIcons.delete), onPressed: (){
                      consumerVar.delateListData(Index);
                      Navigator.of(context).pop();
                    }),
                  ],
                );
              }
            ),
            CupertinoButton(child: Text('Cancel'), onPressed: (){
              Navigator.of(context).pop();
            })
          ],
        ),
      );
    });
  }
  showAlertBox(){
    showCupertinoModalPopup(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){


      return  CupertinoAlertDialog(
        title:  Text('Edit Data',style: TextStyle(fontSize: 20),),
        content: SingleChildScrollView(
          child: Container(
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(radius: 60,backgroundImage: FileImage(image1!),),
                SizedBox(
                  height: 20,
                ),
                CupertinoTextFormFieldRow(
                  controller: nameControllerios,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: 15,),
                CupertinoTextFormFieldRow(
                  controller: numberControllerios,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: 15,),
                CupertinoTextFormFieldRow(
                  controller: chatControllerios,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(left: 19.0),
                  child: GestureDetector(
                    onTap: (){
                      showCupertinoModalPopup(context: context, builder: (context){
                        return Container(
                          height: 300,
                          color: Colors.white,
                          child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: false,
                              onDateTimeChanged: (value){
                               setState(() {
                                 Date=DateFormat("dd-MM-yyyy").format(value);
                               });
                              }),
                        );
                      });
                    },
                    child: Consumer<ProviderClass>(
                      builder: (context,convar,child) {
                        return Row(
                          children: [
                            Icon(CupertinoIcons.calendar),
                            SizedBox(width: 10,),
                            Text(Date!),
                          ],
                        );
                      }
                    ),
                  ),
                ),
                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(left: 19.0),
                  child: GestureDetector(
                    onTap: (){
                      showCupertinoModalPopup(context: context, builder: (context){
                        return Container(
                          height: 300,
                          color: Colors.white,
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            onTimerDurationChanged: (value){
                              setState(() {
                                formatTime = value.toString().substring(0, 8);
                              });
                            },
                          ),
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.time),
                        SizedBox(width: 10,),
                         Text(formatTime!)
                      ],
                    ),
                  ),
                ),
                Consumer<ProviderClass>(
                    builder: (context,ConsumerVar,child) {
                      return CupertinoButton(child: Text('Edit'), onPressed: (){
                        ContactModel contact=ContactModel(name: nameControllerios.text, image: image1, number: numberControllerios.text, chat: chatControllerios.text, date: Date, time: formatTime);
                        ConsumerVar.upDateListData(index1, contact);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    }
                ),
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
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return Center(
      child:(providerVar.contactList.isEmpty)?Center(child: Text('No Any Chat Yet...')): ListView.builder(
          itemCount: providerVar.contactList.length,
          itemBuilder: (context,int index){
            nameControllerios.text=providerVar.contactList[index].name!;
            numberControllerios.text=providerVar.contactList[index].number!;
            chatControllerios.text=providerVar.contactList[index].chat!;
            image1=providerVar.contactList[index].image;
             Date=providerVar.contactList[index].date;
             formatTime=providerVar.contactList[index].time;
            index1=index;
        return CupertinoListTile(
          onTap: (){
            ActionSheet(providerVar.contactList[index].image,providerVar.contactList[index].name,providerVar.contactList[index].chat,index);

          },
          leading: CircleAvatar(radius: 30,backgroundImage: FileImage(providerVar.contactList[index].image!),),
          title: Text(providerVar.contactList[index].name!),
          subtitle: Text(providerVar.contactList[index].chat!),
          trailing: Container(
            // color: Colors.red,
            width: 120,
            height: 40,
            child: Column(
              children: [
                Text(providerVar.contactList[index].date!,style: TextStyle(fontSize: 14),),
                SizedBox(height: 5,),
                Text(providerVar.contactList[index].time!,style: TextStyle(fontSize: 13),),
              ],
            ),
          ),
        );
      }),
    );
  }
}
