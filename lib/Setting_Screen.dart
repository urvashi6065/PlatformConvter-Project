import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider class.dart';

class settingscreen extends StatefulWidget {
  const settingscreen({Key? key}) : super(key: key);

  @override
  State<settingscreen> createState() => _settingscreenState();
}

class _settingscreenState extends State<settingscreen> {
  @override
  void initState() {
    // TODO: implement initState
    getSharedPref();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  getSharedPref() async {
    final providerVar = Provider.of<ProviderClass>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    profileNameVar = pref.getString('name') ?? "";
    bioVar = pref.getString('bio') ?? "";
    image = pref.getString('image') ?? "";
    nameController.text = profileNameVar!;
    bioController.text = bioVar!;
    providerVar.fileImage1 = File(image!);
  }

  String? profileNameVar;
  String? bioVar;
  String? image;

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
                        imageVar.pickImageFromCamera1profile();
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
                        imageVar.pickImageFromGallery1profile();
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
    final providerVar = Provider.of<ProviderClass>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              subtitle: Text('Update Profile Data'),
              trailing: Switch(
                  value: providerVar.getSwitchProfile,
                  onChanged: (value) {
                    providerVar.setSwitchProfile = value;
                  }),
            ),
          ),
          (providerVar.isSwitchProfile == true) ? Container() : Divider(),
          (providerVar.isSwitchProfile == true)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialogBox();
                      },
                      child: (providerVar.fileImage1 != null)
                          ? CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  FileImage(providerVar.fileImage1!),
                            )
                          : CircleAvatar(
                              radius: 70,
                              child: Icon(CupertinoIcons.camera),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: Container(
                        height: 50,
                        width: 200,
                        color: Colors.transparent,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter your name....",
                              border: InputBorder.none),
                          controller: nameController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Container(
                        height: 50,
                        width: 170,
                        color: Colors.transparent,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter your Bio....",
                              border: InputBorder.none),
                          controller: bioController,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              SharedPreferences SharedVar =
                                  await SharedPreferences.getInstance();
                              SharedVar.setString('name', nameController.text);
                              SharedVar.setString('bio', bioController.text);
                              SharedVar.setString(
                                  'image', providerVar.fileImage!.path);
                            },
                            child: Text('SAVE')),
                        TextButton(
                            onPressed: () async {
                              SharedPreferences SharedVar =
                                  await SharedPreferences.getInstance();
                              SharedVar.clear();
                              setState(() {
                                providerVar.fileImage1 = null;
                                nameController.clear();
                                bioController.clear();
                              });
                            },
                            child: Text('CLEAR')),
                      ],
                    ),
                    (providerVar.isSwitchProfile == true)
                        ? Divider()
                        : Container(),
                  ],
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.sun_max,
                color: Colors.blue.shade600,
              ),
              title: Text('Theme'),
              subtitle: Text(
                'Change Theme',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
              trailing: Switch(
                  value: providerVar.getSwitchTheme,
                  onChanged: (value) {
                    providerVar.setSwitchTheme = value;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
