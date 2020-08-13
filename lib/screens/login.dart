import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minsk8/import.dart';

// TODO: flutter_secure_storage для хранения токена авторизации?
// TODO: [MVP] реализовать аутентификацию через: FB, Google, Apple Id, VK, Telegram
// Google Sign In https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed
// Facebook Sign In https://medium.com/@karlwhiteprivate/flutter-facebook-sign-in-with-firebase-in-2020-66556a8c3586
// Apple SignIn https://medium.com/@karlwhiteprivate/flutter-firebase-sign-in-with-apple-c99967df142f
// https://ru.stackoverflow.com/questions/667654/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F-vk-%D0%B2-%D1%81%D0%B2%D1%8F%D0%B7%D0%BA%D0%B5-%D1%81-firebase
// https://qna.habr.com/q/587426
// TODO: как объединять аккаунты https://firebase.google.com/docs/auth/android/account-linking
// TODO: аутентификация через одноразовый пароль в телегу
// http://www.outsidethebox.ms/18835/
// https://habr.com/ru/post/331502/
// https://habr.com/ru/post/321682/
// https://github.com/Flutterando/auth-service/

// Аутентификация пользователя через вк:
// https://firebase.google.com/docs/auth/android/custom-auth
// Надо будет развернуть сервер с firebase admin, авторизовать на нём пользователя из вк,
// получить custom token для firebase, и его уже передавать в firebase auth.
// Либо можно на клиенте авторизовывать в вк, а в firebase передавать как авторизацию по почте,
// придумав пароль за пользователя.

// final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Login'),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                buildInitialRoute(null)(
                  (_) => AuthCheck(),
                  // (_) => App(user: snapshot.data), // TODO: заменить AuthCheck()
                ),
              );
            },
          ),
        ],
      ),
    );
    return Scaffold(
      // appBar: ExtendedAppBar(
      //   withModel: true,
      // ),
      // drawer: MainDrawer('/login'),
      // body: SafeArea(
      //   child: ScrollBody(child: child),
      // ),
      body: child,
    );
  }
}
