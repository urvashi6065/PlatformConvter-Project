import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Provider%20class.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingScreenIOS extends StatefulWidget {
  const settingScreenIOS({Key? key}) : super(key: key);

  @override
  State<settingScreenIOS> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreenIOS> {


  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? nameVar;
  String? bioVar;
  String? image;


  showAlertBox() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Consumer<ProviderClass>(
              builder: (context, consumerVar, child) {
            return CupertinoAlertDialog(
              title: Text('Select From'),
              content: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      consumerVar.pickImageFromCamera1profile();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.camera),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      consumerVar.pickImageFromGallery1profile();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.app_badge),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  getshared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final providerVar = Provider.of<ProviderClass>(context, listen: false);
    nameVar = pref.getString('name') ?? "";
    bioVar = pref.getString('bio') ?? "";
    image = pref.getString('image') ?? "";
    print(image);
    print("image");
    nameController.text = nameVar!;
    bioController.text = bioVar!;
    providerVar.fileImage1 = File(image!);
  }
  // loadImageFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final imageKeyValue = prefs.getString(IMAGE_KEY);
  //   if (imageKeyValue != null) {
  //     final imageString = await ImageSharedPrefs.loadImageFromPrefs();
  //     setState(() {
  //       image = ImageSharedPrefs.imageFrom64BaseString(imageString);
  //     });
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    getshared();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ProviderClass>(context, listen: true);
    return Column(
      children: [
        SizedBox(height: 80,),
        CupertinoListTile(
          title: Text('Profile'),
          leading: Icon(CupertinoIcons.person),
          subtitle: Text('Update Profile Data'),
          trailing: CupertinoSwitch(
              value: providerVar.getSwitchProfile,
              onChanged: (value) {
                providerVar.setSwitchProfile = value;
              }),
        ),
        (providerVar.getSwitchProfile==false)?Divider():Container(),
        GestureDetector(
          onTap: () {
            showAlertBox();
          },
          child: (providerVar.isSwitchProfile == true)
              ? Column(
                  children: [
                    (providerVar.fileImage1 != null)
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(providerVar.fileImage1!),
                          ) : CircleAvatar(
                            radius: 70,
                      child: Icon(CupertinoIcons.camera),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Container(
                        height: 50,
                        width: 200,
                        child: CupertinoTextFormFieldRow(
                          placeholder: "Enter your Name...",
                          controller: nameController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Container(
                        height: 50,
                        width: 200,
                        child: CupertinoTextFormFieldRow(
                          placeholder: "bio",
                          controller: bioController,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                            child: Text('SAVE'),
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                               pref.setString('name', nameController.text);
                              pref.setString('bio', bioController.text);
                              pref.setString(
                                  'image', providerVar.fileImage1!.path);
                            }),
                        CupertinoButton(child: Text('CLEAR'), onPressed: () async {
                           SharedPreferences pref = await SharedPreferences.getInstance();
                             pref.clear();
                             setState(() {
                               providerVar.fileImage1=null;
                             nameController.clear();
                             bioController.clear();
                             });
                        }),
                      ],
                    ),
                  ],
                )
              : Container(),
        ),
        (providerVar.getSwitchProfile==true)?Divider():Container(),
        CupertinoListTile(
          title: Text('Theme'),
          leading: Icon(CupertinoIcons.sun_max),
          subtitle: Text('Chane Theme'),
          trailing: CupertinoSwitch(
              value: providerVar.getSwitchTheme,
              onChanged: (value) {
                providerVar.setSwitchTheme = value;
              }),
        )
      ],
    );
  }
}
