import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:passmaster/Screen/home_Screen.dart';

import '../BE/pass_model.dart';
import '../context.dart';

class editForm extends StatelessWidget {
  editForm({Key? key, required this.Subject, required this.UserName, required this.Password, required this.Index}) : super(key: key);

  final String Subject;
  final String UserName;
  final String Password;
  final int Index;
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late var con;

  @override
  Widget build(BuildContext context) {
    con = context;
    subjectcontroller.text = Subject;
    usercontroller.text = UserName;
    passwordcontroller.text = Password;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KVLightBlueColor,
        elevation: 0,
        title: const Text("Edit Password"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Edit();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      fixedSize: MaterialStateProperty.all(
                          const Size(100,40)
                      )
                  ),
                  child: const Text("Edit",style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Delete();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      fixedSize: MaterialStateProperty.all(
                          const Size(100,40)
                      )
                  ),
                  child: const Text("Delete",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Edit()async{
    var box = await Hive.openBox('pass');
    pass Pass = pass(subjectcontroller.text,usercontroller.text,passwordcontroller.text);
    box.putAt(Index,Pass);
    Navigator.pop(con);
  }

  Delete()async{
    showAlertDialog(con);
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete",style: TextStyle(color: Colors.red),),
      onPressed:  () {
        var box = Hive.box('pass');
        box.deleteAt(Index);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Danjer"),
      content: const Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
