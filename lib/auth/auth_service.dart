import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> handleFcmToken() async {
    if (_user == null) return;

    String? token = await _fcm.getToken();
    if (token != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'fcmToken': token,
      });
    }
  }

  Future<void> clearFcmToken() async {
    if (_user == null) return;
    await _firestore.collection('users').doc(_user!.uid).update({
      'fcmToken': FieldValue.delete(),
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      await handleFcmToken();

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _authError(e.code);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'name': name.isNotEmpty ? name : 'Unknown',
        'email': email,
        'profileImage': '',
        'isVerified': false,
        'fcmToken': '',
        'lastLogin': Timestamp.now(),
      });

      _user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        profileImage: '',
        isVerified: false,
        fcmToken: '',
      );

      await handleFcmToken();

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _authError(e.code);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.sendPasswordResetEmail(email: email);

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _authError(e.code);
    }
  }

  Future<void> signOut() async {
    await clearFcmToken();
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {
        Timestamp lastLogin = (userDoc.data() as Map)['lastLogin'];
        if (DateTime.now().difference(lastLogin.toDate()).inDays <= 30) {
          _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          await handleFcmToken();
          notifyListeners();
          return;
        }
      }
      await signOut();
    }
  }

  String _authError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'This account is not registered';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email already in use';
      default:
        return 'Authentication failed';
    }
  }
}
