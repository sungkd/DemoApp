/* File used to access Firebase Auth Services*/
import 'package:fluuter_provider/modals/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluuter_provider/services/database.dart';

class AuthService {

  // Used to access all Firebase functions
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on firebase user
  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<UserData> get uservalue {
    return _auth.authStateChanges().map((User uservalue) => _userFromFirebaseUser(uservalue));
  }


  // Sign In Anonymous
  Future signInAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    }
    catch (e) {
      print(e.toString());
      return null;
    }

  }

  // Sign In with email & password
  Future sigInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User userval = result.user;
      return _userFromFirebaseUser(userval);
    }

    catch(e) {
      print(e.toString());
      return null;
    }
  }


  // Register with email & password
  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User userval = result.user;

      //create a new document for the user wit the uid
      // await DatabaseService(uid: userval.uid).updateUserData('Indie', 'Female',
      //     '2 weeks old puppy, friendly and playful ',
      //     'Sunny', 12345678, 'Mumbai', 'Not Adopted');

      return _userFromFirebaseUser(userval);
    }

    catch(e) {
      print(e.toString());
      return null;
    }
  }


  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e)
    {
      print(e.toString());
      return null;
    }
  }


}