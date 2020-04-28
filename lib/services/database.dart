import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService{

  final String uid;
  DatabaseService({@required this.uid});
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brew');

  Future updateUserData(String sugar, String name, int strength ) async{
    return await brewCollection.document(uid).setData({
      'sugar' : sugar,
      'name'  : name,
      'strength' : strength
    });
  }

  List<Brew> _brewListFormSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        sugar: doc.data['sugar'],
        name: doc.data['name'],
        strength: doc.data['strength']
      );
    }).toList();
  }

  //get userdata from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot){
      return UserData(
        uid: uid,
        name: documentSnapshot.data['name'],
        strength: documentSnapshot.data['strength'],
        sugars: documentSnapshot.data['sugar']

      );
  }

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFormSnapShot);
  }

  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }
}