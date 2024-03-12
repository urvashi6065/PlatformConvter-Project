import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Provider class.dart';

class cllScreen extends StatefulWidget {
  const cllScreen({Key? key}) : super(key: key);

  @override
  State<cllScreen> createState() => _cllScreenState();
}

class _cllScreenState extends State<cllScreen> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ProviderClass>(context,listen: true);
    return(providerVar.contactList.isEmpty)?Center(child: Text('No Any Call Yet...')): ListView.builder(
        itemCount: providerVar.contactList.length,
        itemBuilder: (context,int index){
          return ListTile(
            leading: CircleAvatar(radius: 30,backgroundImage: FileImage(providerVar.contactList[index].image!),),
            title: Text(providerVar.contactList[index].name!),
            subtitle: Text("+91 " +providerVar.contactList[index].number!),
            trailing: IconButton(onPressed: () async {
             final Uri url=Uri(
               path: providerVar.contactList[index].number,
               scheme: 'tel',
             );
             await launchUrl(url);
            }, icon: Icon(Icons.call,color: Colors.green,),)
          );
        });
  }
}
