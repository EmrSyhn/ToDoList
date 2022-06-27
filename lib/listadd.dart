// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:melike_project/userpage.dart';
import 'components/Button.dart';
import 'components/textFormField.dart';

class ListAdd extends StatefulWidget {
  const ListAdd({Key? key}) : super(key: key);

  @override
  State<ListAdd> createState() => _ListAddState();
}

verileriEkle() async {
  FirebaseAuth yetki = FirebaseAuth.instance;
  final kullanici = await yetki.currentUser!;
  String uidTutucu = kullanici.uid;
  await FirebaseFirestore.instance
      .collection("taskLists")
      .doc(uidTutucu)
      .collection("myList")
      .doc()
      .set(
    {
      "taskName": GorevAdi.text,
      "myContents": GorevIci.text,
    },
  );

  Fluttertoast.showToast(msg: "Görev Eklendi");
  GorevAdi.clear();
  GorevIci.clear();
}

TextEditingController GorevAdi = TextEditingController();
TextEditingController GorevIci = TextEditingController();

class _ListAddState extends State<ListAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2c0c0),
      appBar: AppBar(
        backgroundColor: const Color(0xffc2c0c0),
        toolbarHeight: 40,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const Text(
                  'Görevlerinizi Ekleyin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/40.png',
                  width: 120,
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      MainTextFormField(
                        LabelText: 'Görev Adi',
                        ControllerDenetleyici: GorevAdi,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MainTextFormField(
                          LabelText: 'Görev İçeriği',
                          ControllerDenetleyici: GorevIci),
                      const SizedBox(
                        height: 20,
                      ),
                      MainButton(
                          press: () async {
                            await verileriEkle();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserPages()),
                            );
                          },
                          text: 'Ekle'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
