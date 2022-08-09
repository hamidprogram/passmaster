import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../BE/pass_model.dart';
import '../context.dart';
import 'add_screen.dart';
import 'edit_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  GlobalKey<ScaffoldState> _scaffolKEy = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KVLightBlueColor,
        elevation: 0,
        title: const Center(child: Text("PaasMaster", style: TextStyle(fontSize: 20))),
        actions: [
          IconButton(
              onPressed: () {
                exit(0);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const Center(
                child: Text("PassMaster",style: TextStyle(fontSize: 20),),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 125),
                height: (MediaQuery.of(context).size.height - 400),
                decoration: BoxDecoration(
                    color: KLightGrayColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: const [
                      Text("Hamid Reza Shojai",style: TextStyle(fontSize: 17),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("hamidprogram@gmail.com",style: TextStyle(fontSize: 17),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("09138742015",style: TextStyle(fontSize: 17),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("hamid_programer_pro",style: TextStyle(fontSize: 17),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: Hive.openBox('pass'),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return passList();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget passList() {
    Box passBox = Hive.box("pass");
    return ValueListenableBuilder(
        valueListenable: passBox.listenable(),
        builder: (context, Box box, child) {
          if (box.values.isEmpty) {
            return const Center(
                child: Text(
              'No password',
              style: TextStyle(color: Colors.white),
            ));
          } else {
            return SizedBox(
                height: (MediaQuery.of(context).size.height - 120),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: passBox.length,
                    itemBuilder: (context, index) {
                      final pass Pass = box.getAt(index);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editForm(
                                      Subject: Pass.subject,
                                      UserName: Pass.username,
                                      Password: Pass.password,
                                      Index: index,
                                    )),
                          );
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 0, color: kBlueColor)),
                          color: kBlueColor,
                          child: ListTile(
                            leading: const Icon(Icons.key),
                            title: Text(Pass.subject),
                          ),
                        ),
                      );
                    }));
          }
        });
  }
}
