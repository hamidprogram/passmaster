import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passmaster/BE/pass_model.dart';
import 'package:passmaster/Screen/home_Screen.dart';
import 'package:passmaster/context.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(passAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: KVLightBlueColor),
    );
  }
}
