import 'package:flutter/foundation.dart';

class AppController extends ChangeNotifier{
  int counter = 0;
  String avatar = "";
  String name = "";
  String email = "";
  int currentIndex = 0;

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
}