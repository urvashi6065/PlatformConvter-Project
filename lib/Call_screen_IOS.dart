import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Provider%20class.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class callScreenIOS extends StatefulWidget {
  const callScreenIOS({Key? key}) : super(key: key);

  @override
  State<callScreenIOS> createState() => _callScreenState();
}

class _callScreenState extends State<callScreenIOS> {
  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return (providerVar.contactList.isEmpty)?Center(child: Text('No Any Call Yet...')):ListView.builder(
        itemCount: providerVar.contactList.length,
        itemBuilder: (context,int index){
          return CupertinoListTile(title: Text(providerVar.contactList[index].name!),leading: CircleAvatar(radius: 70,backgroundImage: FileImage(providerVar.contactList[index].image!),),subtitle: Text("+91 "+providerVar.contactList[index].number!),trailing: CupertinoButton(onPressed: () async {
            final Uri url=Uri(
              path: providerVar.contactList[index].number,
              scheme: 'tel',
            );
            await launchUrl(url);
          },
            child: Icon(CupertinoIcons.phone,color: Colors.green,),),);
        });
  }
}