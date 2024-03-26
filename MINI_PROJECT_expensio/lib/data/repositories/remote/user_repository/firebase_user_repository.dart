import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/domain/exceptions/app_exception.dart';
import '/data/models/user_model.dart';
import '/data/repositories/remote/user_repository/user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUserData(UserModel newUser) async {
    await _userCollection
        .doc(newUser.uId)
        .set(newUser.toMap())
        .catchError(AppExceptionHandler.handleFirebaseException);
  }

  @override
  Future<UserModel> getUserById() async {
    final auth = FirebaseAuth.instance.currentUser;
    return await _userCollection
        .doc(auth?.uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()!))
        .catchError(AppExceptionHandler.handleFirebaseException);
  }

  ///Singleton factory
  static final FirebaseUserRepository _instance =
      FirebaseUserRepository._internal();

  factory FirebaseUserRepository() {
    return _instance;
  }

  FirebaseUserRepository._internal();
}
