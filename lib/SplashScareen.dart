import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'introScareen.dart';

class SplashScareen extends StatefulWidget {
  const SplashScareen({Key? key}) : super(key: key);

  @override
  State<SplashScareen> createState() => _SplashScareenState();
}

class _SplashScareenState extends State<SplashScareen> {
  bool isIntroVar=false;
  @override
  void initState() {
    // TODO: implement initState
    getshared();
    Timer(Duration(seconds: 3), () {
      if(isIntroVar==true){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage(title: 'title')), (route) => false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Intro_Scareen()), (route) => false);
      }
    });
    super.initState();
  }
  getshared() async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    isIntroVar=sharedVar.getBool('isShared')??false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Scareen',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
