import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro_Scareen extends StatefulWidget {
  const Intro_Scareen({Key? key}) : super(key: key);

  @override
  State<Intro_Scareen> createState() => _Intro_ScareenState();
}

class _Intro_ScareenState extends State<Intro_Scareen> {
  PageController pageController =PageController();
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro Scareen'),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value){
          setState(() {
            index=value;
          });
        },
        children: [
          Column(
            children: [
              Text('Intro Scareen 1'),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                setState(() {
                  pageController.jumpToPage(index+1);
                });
              }, child: Text('Next'))
            ],
          ),
          Column(
            children: [
              Text('Intro Scareen 2'),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                setState(() {
                  pageController.jumpToPage(index+1);
                });
              }, child: Text('Next')),
              ElevatedButton(onPressed: (){
                setState(() {
                  pageController.jumpToPage(index-1);
                });
              }, child: Text('Privious'))
            ],
          ),
          Column(
            children: [
              Text('Intro Scareen 3'),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                SharedPreferences sharedVar=await SharedPreferences.getInstance();
                sharedVar.setBool('isShared', true);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage(title: 'title')), (route) => false);
              }, child: Text('Next')),
              ElevatedButton(onPressed: (){
                setState(() {
                  pageController.jumpToPage(index-1);
                });
              }, child: Text('Privious'))
            ],
          ),
        ],
      ),

    );
  }
}
