
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pageviewbottomnavigatiohnadvanceflutter/Add_contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_Class.dart';

class ProviderClass with ChangeNotifier{
  bool isSwitchTheme=false;
  bool isPlatform=false;
  int index=0;
  File? fileImage;
  File? fileImage1;
  bool isSwitchProfile=false;
 //  String? formateDate;
 String? formateTime;
  List<ContactModel> contactList=[];

  ProviderClass(){
    getThemeShared();
    getPlatformShared();
  }

  set setSwitchTheme(value){
    isSwitchTheme=value;
    setThemeShared(value);
    notifyListeners();
  }
  get getSwitchTheme{
    return isSwitchTheme;
  }
  set setSwitchValuePlatForm(value){
    isPlatform=value;
    setPlatformShared(value);
    notifyListeners();
  }
  get getSwitchValuePlatForm{
    return isPlatform;
  }

  pickImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      fileImage = File(image.path);
      notifyListeners();
    }
  }

  pickImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      fileImage = File(image.path);
      notifyListeners();
    }
  }
  pickImageFromGallery1profile() async {
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image1 != null) {
      fileImage1 = File(image1.path);
      notifyListeners();
    }
  }

  pickImageFromCamera1profile() async {
    var image1 = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image1 != null) {
      fileImage1= File(image1.path);
      notifyListeners();
    }
  }

  addListData(ContactModel contact){
    contactList.add(contact);
    notifyListeners();
  }
  upDateListData(int index,contact){
    contactList[index]=contact;
    notifyListeners();
  }
  delateListData(index){
    contactList.removeAt(index);
    notifyListeners();
  }
  get getListData{
    return contactList;
  }
  set setSwitchProfile(value){
    isSwitchProfile=value;
    notifyListeners();
  }
  get getSwitchProfile{
    return isSwitchProfile;
  }


  // set setNullDate(value){
  //   formateDate=value;
  //   notifyListeners();
  // }

  set setDate(value){
    // formatedate=DateFormat("dd-MM-yyyy").format(value);
    notifyListeners();
  }
  get getDate{
    // return formatedate;
  }

  setTime(value,context){
    final time1=MaterialLocalizations.of(context);
    formateTime=time1.formatTimeOfDay(value!);
    notifyListeners();
  }
  // setTimeios(value){
  //   formateTime = value.toString().substring(0, 8);
  //   notifyListeners();
  // }
  getTime(){
    return formateTime;
  }
  setThemeShared(value) async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    sharedVar.setBool('isSwitch', value);
    notifyListeners();
  }
  getThemeShared() async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    isSwitchTheme=sharedVar.getBool('isSwitch')??false;
    notifyListeners();
  }
  setPlatformShared(value) async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    sharedVar.setBool('isplatform', value);
    notifyListeners();
  }
  getPlatformShared() async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    isPlatform = sharedVar.getBool('isplatform')??false;
    notifyListeners();
  }
}