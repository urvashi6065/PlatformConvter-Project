import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Add_contact.dart';
import 'Call_screen.dart';
import 'Chat_screen.dart';
import 'Ios Screen.dart';
import 'Model_Class.dart';
import 'Provider class.dart';
import 'Setting_Screen.dart';
import 'demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ProviderClass())],
      child: Consumer<ProviderClass>(builder: (context, platformVar, child) {
        return (platformVar.getSwitchValuePlatForm == true)
            ? CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: (platformVar.getSwitchTheme==true)?CupertinoThemeData(
                  brightness: Brightness.dark):CupertinoThemeData(
                    brightness: Brightness.light),
                home: IOS_Scareen(),
              )
            : MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: (platformVar.getSwitchTheme==true)?ThemeData.dark(useMaterial3: true):ThemeData.light(useMaterial3: true),
                home: const MyHomePage(title: 'Flutter Demo Home Page'),
              );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  get index => null;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  String formatedate = '';

  @override
  Widget build(BuildContext context) {
    print(Platform.isAndroid);
    print(Platform.isIOS);
    final providerVar = Provider.of<ProviderClass>(context,listen: true);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Platform Converter'),
            bottom: TabBar(
              // isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
                tabs: [
              Tab(
                icon: Icon(Icons.person_add_alt),
              ),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "CALLS",
              ),
                  Tab(
                    text: "SETTING",
                  ),
            ]),
            actions: [
              Switch(value: providerVar.getSwitchValuePlatForm, onChanged: (value){
                providerVar.setSwitchValuePlatForm=value;
              })
            ],
          ),
          body: TabBarView(
            children: [
               addContact(),
              chatScreen(),
              cllScreen(),
              settingscreen(),
            ],
          ),
        ));
    // return Scaffold(
    //   appBar: AppBar(
    //     // backgroundColor: Colors.blue,
    //     title: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text('Platform Converter'),
    //             Switch(
    //                 value: providerVar.getSwitchValuePlatForm,
    //                 onChanged: (value) {
    //                   providerVar.setSwitchValuePlatForm = value;
    //                 })
    //           ],
    //         ),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             IconButton(
    //                 onPressed: () {
    //                   providerVar.indexFunction();
    //                 },
    //                 icon: Icon(Icons.person_add_alt)),
    //             TextButton(
    //                 onPressed: () {
    //                   providerVar.indexFunction1();
    //                 },
    //                 child: Text('CHATS')),
    //             TextButton(
    //                 onPressed: () {
    //                   providerVar.indexFunction2();
    //                 },
    //                 child: Text('CALLS')),
    //             TextButton(
    //                 onPressed: () {
    //                   providerVar.indexFunction3();
    //                 },
    //                 child: Text('SETTINGS'))
    //           ],
    //         ),
    //       ],
    //     ),
    //     toolbarHeight: 100,
    //   ),
    //   body: SingleChildScrollView(
    //     child: IndexedStack(
    //       index: providerVar.index,
    //       children: [
    //         Center(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Divider(),
    //                 InkWell(
    //                     onTap: () {
    //                       showDialogBox();
    //                     },
    //                     child: (providerVar.fileImage != null)
    //                         ? CircleAvatar(
    //                       radius: 70,
    //                       backgroundImage:
    //                       FileImage(providerVar.fileImage!),
    //                     )
    //                         : CircleAvatar(
    //                       radius: 70,
    //                       child: Icon(CupertinoIcons.camera_on_rectangle),
    //                     )),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(
    //                       height: 25,
    //                     ),
    //                     TextFormField(
    //                       decoration: InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           prefixIcon: Icon(CupertinoIcons.person),
    //                           hintText: "Full Name",
    //                           label: Text('Full Name')),
    //                       controller: nameController,
    //                     ),
    //                     SizedBox(
    //                       height: 15,
    //                     ),
    //                     TextFormField(
    //                       decoration: InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           prefixIcon: Icon(Icons.call),
    //                           hintText: "Phone Number",
    //                           label: Text('Phone Number')),
    //                       controller: numberController,
    //                     ),
    //                     SizedBox(
    //                       height: 15,
    //                     ),
    //                     TextFormField(
    //                       decoration: InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           prefixIcon: Icon(Icons.chat_outlined),
    //                           hintText: "Chat Conversation",
    //                           label: Text('Chat Conversation')),
    //                       controller: chatController,
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     InkWell(
    //                       onTap: () async {
    //                         var date = await showDatePicker(
    //                             context: context,
    //                             initialDate: DateTime.now(),
    //                             firstDate: DateTime(1996),
    //                             lastDate: DateTime(2050));
    //                         print(date);
    //                         setState(() {
    //                           formatedate =
    //                               DateFormat("dd-MM-yyyy").format(date!);
    //                         });
    //                       },
    //                       child: Container(
    //                         height: 40,
    //                         width: 120,
    //                         color: Colors.white,
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Icon(Icons.date_range_outlined),
    //                             (formatedate != '')
    //                                 ? Text(formatedate)
    //                                 : Text('Pick Date')
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 30,
    //                       width: 102,
    //                       color: Colors.white,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Icon(CupertinoIcons.clock),
    //                           Text('Pick Time')
    //                         ],
    //                       ),
    //                     ),
    //                     Center(
    //                         child: OutlinedButton(
    //                             onPressed: () {
    //                               print(nameController);
    //                               print(numberController);
    //                               print(chatController);
    //
    //                               Model_Class contact = Model_Class(
    //                                   image: providerVar.fileImage,
    //                                   name: nameController.text,
    //                                   number: numberController.text,
    //                                   chat: chatController.text,
    //                                   date: formatedate);
    //                               providerVar.addListData(contact);
    //
    //                               nameController.clear();
    //                               numberController.clear();
    //                               chatController.clear();
    //                               providerVar.fileImage = null;
    //                               setState(() {
    //                                 formatedate = '';
    //                               });
    //                               print(context);
    //                             },
    //                             child: Text('SAVE')))
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           height: 500,
    //           child: ListView.builder(
    //               itemCount: providerVar.contactList.length,
    //               itemBuilder: (context, int index) {
    //                 return ListTile(
    //                   onTap: () {
    //                     openBottomsheet(providerVar.contactList[index].image,providerVar.contactList[index].name,providerVar.contactList[index].chat);
    //                   },
    //                   leading: CircleAvatar(
    //                     radius: 30,
    //                     backgroundImage: FileImage(providerVar.contactList[index].image!),
    //                   ),
    //                   title: Text(providerVar.contactList[index].name!),
    //                   subtitle: Text(providerVar.contactList[index].chat!),
    //                   trailing: Container(
    //                     width: 115,
    //                     child: Row(
    //                       children: [
    //                         Text(providerVar.contactList[index].date!),
    //                         Text(', '),
    //                         Text('Time'),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               }),
    //         ),
    //         //CALLS
    //         Container(
    //           height: 500,
    //           child: ListView.builder(
    //               itemCount: providerVar.contactList.length,
    //               itemBuilder: (context,int index){
    //                 return ListTile(
    //                   leading: CircleAvatar(radius: 30,backgroundImage: FileImage(providerVar.contactList[index].image!),),
    //                   title: Text(providerVar.contactList[index].name!),
    //                   subtitle: Text(providerVar.contactList[index].chat!),
    //                   trailing: IconButton(onPressed: () async {
    //                     final Uri url=Uri(path:providerVar.contactList[index].number, scheme: 'tel',);
    //                     await launchUrl(url);
    //                   }, icon: Icon(Icons.call,color: Colors.green,),),
    //                 );
    //
    //               }),
    //         ),
    //         //SETTINGS
    //         Column(
    //           children: [
    //             Divider(),
    //             Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: ListTile(
    //                 leading: Icon(Icons.person),
    //                 title: Text('Profile'),
    //                 subtitle: Text('Update Profile Data'),
    //                 trailing: Switch(value: providerVar.getSwitchProfile, onChanged: (value){
    //                   providerVar.setSwitchProfile=value;
    //                 }),
    //               ),
    //             ),
    //             (providerVar.isSwitchProfile==true)?Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               // crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //
    //                 CircleAvatar(
    //                   radius: 70,
    //                   child: Icon(CupertinoIcons.camera),
    //                 ),
    //                 Container(
    //                   height: 50,
    //                   width: 200,
    //                   color: Colors.red,
    //                   child: TextFormField(
    //                     decoration: InputDecoration(
    //
    //                         hintText: "Enter your name....",
    //                         border: InputBorder.none
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ):Container()
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

}
