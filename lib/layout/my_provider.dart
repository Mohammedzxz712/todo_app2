import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app3/models/user_model.dart';
import 'package:todo_app3/screens/setting/setting_tab.dart';
import 'package:todo_app3/screens/task/task_tab.dart';

import '../models/task_model.dart';

class MyProvider extends ChangeNotifier {
  UserModel? user;
  User? firebaseUser;
  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    user = await getUser(firebaseUser!.uid);
    notifyListeners();
  }

  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screen = [TaskTab(), SettingTab()];

  CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  Future<void> addUser(UserModel userModel) {
    var collection = getUserCollection();
    var docsRef = collection.doc(userModel.id);
    return docsRef.set(userModel);
  }

  Future<void> addTask(TaskModel task) async {
    var collection = getTaskCollection();
    var docRef = collection.doc();

    task.id = docRef.id;
    await docRef.set(task);
    notifyListeners();
  }

  IconData visible = Icons.visibility_outlined;
  bool obscureText = true;

  void changeVisiblePassword() {
    obscureText = !obscureText;
    obscureText
        ? visible = Icons.visibility_outlined
        : visible = Icons.visibility_off_outlined;
    notifyListeners();
  }

  // void getTask() async {
  //   model = [];
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('tasks').get();
  //   model.addAll(querySnapshot.docs);
  //   notifyListeners();
  // }

  Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    return getTaskCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  void updateUser({
    required String description,
    required String title,
    required String id,
    required int date,
    required bool isDone,
  }) {
    TaskModel model = TaskModel(
      userId: FirebaseAuth.instance.currentUser!.uid,
      date: date,
      description: description,
      title: title,
      isDone: isDone,
      id: id,
    );
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update(model.toJson())
        .then((value) {
      // notifyListeners();
    }).catchError((error) {
      print(error.toString());
      notifyListeners();
    });
  }

  Future<void> deleteTask(String taskId) {
    return getTaskCollection().doc(taskId).delete();
  }

  Future<void> createUser(String email, String phone, String name,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //credential.user?.sendEmailVerification();
      UserModel userModel = UserModel(
          name: name, phone: phone, email: email, id: credential.user!.uid);
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot<UserModel> docData =
        await getUserCollection().doc(id).get();

    return docData.data();
  }

  Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if (credential.user!.emailVerified) {

      onSuccess();

      // } else {
      //   onError("Please verify Email");
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        onError("Wrong Email OR password");
      }
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    }
  }
}
