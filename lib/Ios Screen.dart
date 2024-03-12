import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Add_contact_IOS.dart';
import 'Call_screen_IOS.dart';
import 'Chat_screen.dart';
import 'Chat_screen_IOS.dart';
import 'Provider class.dart';
import 'Setting_screen_IOS.dart';

class IOS_Scareen extends StatefulWidget {
  const IOS_Scareen({super.key});

  @override
  State<IOS_Scareen> createState() => _IOS_ScareenState();
}

class _IOS_ScareenState extends State<IOS_Scareen> {
  List<Widget> screenList = [
    addcontactIOS(),
    chatScreenIOS(),
    callScreenIOS(),
    settingScreenIOS(),
  ];

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ProviderClass>(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text('Platform Converter'),
          trailing: CupertinoSwitch(
              value: providerVar.getSwitchValuePlatForm, onChanged: (value) {
                providerVar.setSwitchValuePlatForm=value;
          })),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_2), label: 'CHATS'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.phone), label: 'CALLS'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: 'SETTINGS'),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Center(
                  child: screenList[index],
                );
              },
            );
          }),
    );
  }
}
