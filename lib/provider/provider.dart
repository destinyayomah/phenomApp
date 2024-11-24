import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        throw Exception('invalid email');
      } else if (error.code == 'weak-password') {
        throw Exception('invalid password');
      } else if (error.code == 'user-not-found') {
        throw Exception('No user found for this email.');
      } else {
        throw Exception('Login failed. Invalid Credentials');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getSocialLinks() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('social_links').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getSignupPopup() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('signup_popup').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getHeroImage() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('hero_image').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getHowItWorksPopup() async {
    var querySnapshot = await firestore
        .collection('phenom2025')
        .doc('how_it_works_popup')
        .get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getWhatIsPhenom() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('what_is_phenom').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getWaitlist() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('waitlist').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getSlides() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('slides').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getWhyChooseUs() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('why_choose_us').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getVideos() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('videos').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }

  Future<dynamic> getEarningStructure() async {
    var querySnapshot =
        await firestore.collection('phenom2025').doc('earning_structure').get();
    if (querySnapshot.data() != null) {
      notifyListeners();
    }
    return querySnapshot;
  }
}
