import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melike_project/userpage.dart';
import 'components/Button.dart';
import 'components/DialogMesaj.dart';
import 'components/TextButton.dart';
import 'components/TextFormField.dart';
import 'loginpage.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({Key? key}) : super(key: key);

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

TextEditingController name = TextEditingController();
TextEditingController mail = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController passagain = TextEditingController();
final _dogrulamaAnahtari = GlobalKey<FormState>();

class _RegisterPagesState extends State<RegisterPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2c0c0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Kayıt Ekranına Hoşgeldiniz!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  const Text('Kayıt olun ve size yardımcı olalım'),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Form(
                              key: _dogrulamaAnahtari,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  MainTextFormField(
                                      LabelText: 'Adınızı Giriniz',
                                      ControllerDenetleyici: name),
                                  const SizedBox(height: 20),
                                  MainTextFormField(
                                      LabelText: 'Mail Adresinizi Giriniz',
                                      ControllerDenetleyici: mail),
                                  const SizedBox(height: 20),
                                  MainTextFormField(
                                      obscureText: true,
                                      LabelText: 'Parolanızı Giriniz',
                                      ControllerDenetleyici: pass),
                                  const SizedBox(height: 20),
                                  MainTextFormField(
                                      obscureText: true,
                                      LabelText: 'Parolanızı Tekrar Giriniz',
                                      ControllerDenetleyici: passagain),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      MainButton(
                          press: () async {
                            if (pass.text != passagain.text) {
                              DialogMesaj(context, msg: 'Parolanız hatalı');
                            } else if (_dogrulamaAnahtari.currentState!
                                .validate()) {
                              final kullaniciolusturma = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: name.text, password: pass.text);
                              final uidTututcu = kullaniciolusturma.user?.uid;
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uidTututcu)
                                  .set({
                                "userName": name.text,
                                "Email": mail.text,
                                "passwords:": pass.text
                              });
                              //Kullanıcı Verisi Kontrol Etme
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserPages()),
                              );
                            }
                          },
                          text: 'Kayıt Ol'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Hesabın var mı?'),
                          MainTextButton(
                              TextYazisi: 'Giriş Yap',
                              Press: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPages(),
                                  ),
                                );
                              },
                              size: 20)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
