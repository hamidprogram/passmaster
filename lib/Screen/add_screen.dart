import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passmaster/BE/pass_model.dart';

import '../context.dart';

class addForm extends StatelessWidget {
  addForm({Key? key}) : super(key: key);

  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late var con;

  @override
  Widget build(BuildContext context) {
    con = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KVLightBlueColor,
        elevation: 0,
        title: const Text("Add Password"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: subjectcontroller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: kBlueColor),
                  ),
                  labelText: 'Subject'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: usercontroller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: kBlueColor),
                  ),
                  labelText: 'UserName'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordcontroller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: kBlueColor),
                  ),
                  labelText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                add(subjectcontroller.text,usercontroller.text,passwordcontroller.text);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPinkColor),
                  fixedSize: MaterialStateProperty.all(
                      const Size(100,40)
                  )
              ),
              child: const Text("Add",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
  add(String Subject,String UserName,String Password)async{
    var box = await Hive.box('pass');
    pass Pass = pass(Subject,UserName,Password);
    box.add(Pass);
    subjectcontroller.clear();
    usercontroller.clear();
    passwordcontroller.clear();
    Navigator.pop(con);
  }
}
