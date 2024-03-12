import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Add_contact.dart';
import 'package:provider/provider.dart';

import 'Provider class.dart';
import 'model_Class.dart';

class addcontactIOS extends StatefulWidget {
  const addcontactIOS({Key? key}) : super(key: key);

  @override
  State<addcontactIOS> createState() => _addcontactState();
}

class _addcontactState extends State<addcontactIOS> {
  showAlertBox(){
    showCupertinoModalPopup(context: context, builder: (context){
    return  Consumer<ProviderClass>(
      builder: (context,consumerVar,child) {
        return CupertinoAlertDialog(
            title: Text('Select From'),
            content: Column(
              children: [
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: (){
                    consumerVar.pickImageFromCamera();
                    Navigator.of(context).pop();

                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.camera),
                      SizedBox(width: 10,),
                      Text('Camera'),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    consumerVar.pickImageFromGallery();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.app_badge),
                      SizedBox(width: 10,),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          );
      }
    );
    });
  }

  // showDate(){
  //   showCupertinoModalPopup(context: context, builder: (context){
  //     return Consumer<ProviderClass>(
  //       builder: (context,convar,child) {
  //         return Container(
  //           height: 300,
  //           color: Colors.white,
  //           child: CupertinoDatePicker(
  //               initialDateTime: DateTime.now(),
  //               mode: CupertinoDatePickerMode.date,
  //                use24hFormat: false,
  //               onDateTimeChanged: (value){
  //                 convar.setDate=value;
  //           }),
  //         );
  //       }
  //     );
  //   });
  // }
  TextEditingController nameController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController chatController=TextEditingController();
  String? formatedate;
  String? formateTime;

  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return Form(
      key: formkey,
      child: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: GestureDetector(
                onTap: (){
                  showAlertBox();
                },
                child:(providerVar.fileImage!=null) ?CircleAvatar(radius: 70,backgroundImage: FileImage(providerVar.fileImage!),):CircleAvatar(radius: 70,child: Icon(CupertinoIcons.camera_on_rectangle,color: Colors.white,),backgroundColor: Colors.blue.shade600)),
          ),
         Padding(
           padding: const EdgeInsets.only(right: 20.0),
           child: CupertinoTextFormFieldRow(
             textInputAction: TextInputAction.next,
             prefix: Icon(CupertinoIcons.person),
             placeholder: "Full Name",
             placeholderStyle: TextStyle(color:(providerVar.getSwitchTheme==true)? Colors.white:Colors.black),
             controller: nameController,
             decoration: BoxDecoration(
               border: Border.all(color: Colors.grey),
               borderRadius: BorderRadius.circular(5),
             ),
             validator: (value){
               if(value!.isEmpty){
                 return "Enter Full Name";
               }
             },
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CupertinoTextFormFieldRow(
              textInputAction: TextInputAction.next,
              controller: numberController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              prefix: Icon(CupertinoIcons.phone),
              placeholder: "Phone Number",
              placeholderStyle: TextStyle(color: (providerVar.getSwitchTheme==true)? Colors.white:Colors.black),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Phone Number";
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CupertinoTextFormFieldRow(
              textInputAction: TextInputAction.next,
              controller: chatController,
              placeholderStyle: TextStyle(color: (providerVar.getSwitchTheme==true)? Colors.white:Colors.black),
              prefix: Icon(CupertinoIcons.chat_bubble_text),
              placeholder:"Chat Conversation",
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Chat Conversation";
                }
              },
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
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
                            formatedate=DateFormat("dd-MM-yyyy").format(value);
                          });
                        }),
                  );
                });
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.calendar),
                  SizedBox(width: 10,),
                  (formatedate!=null)?Text(formatedate!):Text('Pick Date'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
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
                          formateTime = value.toString().substring(0, 8);
                        });
                      },
                    ),
                  );

                });
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.clock),
                  SizedBox(width: 10,),
                  (formateTime!=null)?Text(formateTime!):Text('Pick Time'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          CupertinoButton(child: Text('SAVE'), onPressed: (){
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
              }
            }
            print(providerVar.getDate);
          },color: Colors.blue.shade600,)
        ],
      ),
    );
  }
}
