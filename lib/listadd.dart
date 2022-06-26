// ignore_for_file: file_names, non_constant_identifier_names, await_only_futures, use_build_context_synchronously, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:melike_project/userpage.dart';
import 'components/Button.dart';
import 'components/TextFormField.dart';

//StatlessWidget'e geçildi
class ListEkleme extends StatelessWidget {
  TextEditingController GorevAdi = TextEditingController();
  TextEditingController GorevIci = TextEditingController();
  ListEkleme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCF7751),
        title: const Text("Görev Ekleme"),
      ),
      backgroundColor: const Color(0xFFE6E6E6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  const Text('Lütfen List Ekleyiniz',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 30),
                  const Text('Görevinde yardimci olayim',
                      style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 15),
                  Image.asset('assets/images/2.png'),
                  SizedBox(height: 19),
                  //formlar
                  Form(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          MainTextFormField(
                            ControllerDenetleyici: GorevAdi,
                            LabelText: 'Görev Gir',
                          ),
                          const SizedBox(height: 10),
                          MainTextFormField(
                            ControllerDenetleyici: GorevIci,
                            LabelText: 'İçeriği Gir',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MainButton(
                      press: () async {
                        await biseyler();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserPages()),
                        );
                      },
                      text: 'Kaydet'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  biseyler() {
    return () async {
      FirebaseAuth yetki = FirebaseAuth.instance;
      final kullanici = await yetki.currentUser!;
      const bool taskComplatet = false;
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
          "taskComplatet": taskComplatet
        },
      );

      Fluttertoast.showToast(msg: "Görev Eklendi");
      GorevAdi.clear();
      GorevIci.clear();
    };
  }
}
