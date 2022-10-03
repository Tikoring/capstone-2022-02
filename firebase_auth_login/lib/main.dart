import 'package:firebase_auth_login/helper/join_or_login.dart';
import 'package:firebase_auth_login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_login/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      /*home: ChangeNotifierProvider<JoinOrLogin>.value(
      value: JoinOrLogin(),
      child: AuthPage()),*/
      home: HomePage (),
    );
  }
}