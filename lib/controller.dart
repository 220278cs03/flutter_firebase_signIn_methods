import 'package:flutter/foundation.dart';

class AppController extends ChangeNotifier{
  int counter = 0;
  String avatar = "";
  String name = "NAME";
  String email = "EMAIL";
  int currentIndex = 0;
  String facebook_name = "NAME";
  String facebook_image = "IMAGE";
  String facebook_id = "ID";

  setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }


  AddCount(){
    counter+=1;
    notifyListeners();
  }
  getAvatar(String avatar){
    this.avatar = avatar;
    notifyListeners();
  }

  getName(String name){
    this.name = name;
    notifyListeners();
  }

  getEmail(String email){
    this.email = email;
    notifyListeners();
  }

  getFacebookName(String facebook_name){
    this.facebook_name = facebook_name;
    notifyListeners();
  }

  getFacebookImage (String facebook_image){
    this.facebook_image = facebook_image;
    notifyListeners();
  }

  getFacebookId(String facebook_id){
    this.facebook_id = facebook_id;
    notifyListeners();
  }
}