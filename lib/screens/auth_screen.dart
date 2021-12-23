import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:chat_app/widgets/auth/auth_form.dart';
import '../constants.dart';
import 'chats_screen/chats_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _doneAuth() {
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatsScreen(),
    ));
  }

  void _submitAuthForm({
    required String email,
    required String password,
    required String username,
    required bool isLogin,
    required BuildContext ctx,
  }) async {
    //......
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print("_doneAuth()");
        _doneAuth();
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username, 'email': email});
        print("_doneAuth()");
        _doneAuth();
      }
    } on PlatformException catch (err) {
      var message = 'An Error Occurred,Please check your credentials !';
      if (err.message != null || err.message!.isNotEmpty) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kPrimaryColor,
      body: AuthForm(submitFn: _submitAuthForm, isLoading: _isLoading),
    );
  }
}
