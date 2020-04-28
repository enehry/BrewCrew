
import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
     return user != null ? User(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anonymously
  Future signInAnon () async{
      try{
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      }
      catch(e){
        return null;
      }
  }


  // sing in with email and password
  Future signInEmail(String email, String pass) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
    }
  }


  // register using email and password
  Future registerEmail(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).updateUserData('0','new brew crew member', 100);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }


  }


  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}