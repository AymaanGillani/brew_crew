import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Reference to a collection
  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }

  //get brew list from snapshot
  List<Brew>_brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name']??'',
        sugars: doc.data['sugars']??'',
        strength: doc.data['strength']??0,
      );
    }).toList();
  }
  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  //Get brews streams
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
  //Get userd doc stream
  Stream<UserData> get userData{
    return  brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
