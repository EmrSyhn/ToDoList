import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/Button.dart';
import 'components/TextButton.dart';
import 'components/TextFormField.dart';
import 'registerpage.dart';
import 'userpage.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

TextEditingController t1 = TextEditingController();
TextEditingController pass = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _LoginPagesState extends State<LoginPages> {
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
                  const Text('Tekrar Hoşgeldin!'),
                  const SizedBox(height: 20),
                  const Text('Görevlerini oluşturmanda yardımcı olabilirim'),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/2.png'),
                  Row(
                    key: _formKey,
                    children: [
                      SizedBox(
                        height: 400,
                        width: 300,
                        child: Form(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              MainTextFormField(
                                  LabelText: 'E-mail',
                                  ControllerDenetleyici: t1),
                              const SizedBox(height: 20),
                              MainTextFormField(
                                  obscureText: true,
                                  LabelText: 'Parolanız',
                                  ControllerDenetleyici: pass),
                              const SizedBox(height: 20),
                              MainButton(
                                  press: () async {
                                    //1. kullanıcı verisini kontrol et
                                    // ignore: unnecessary_null_comparison
                                    if (t1.text == null || pass.text == null) {
                                      dialogMesaj(context);
                                    } else {
                                      // 2. Kullanıcı bilgileriile girşi yapmayı dene
                                      try {
                                        final giris = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: t1.text,
                                                password: pass.text);
                                        print(giris);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserPages()),
                                        );
                                        // 3. hata varsa kullanıcıya nesaj ver
                                      } on FirebaseAuthException catch (e) {
                                        print(e);
                                        var msg = '';
                                        if (e.code == 'user-not-found') {
                                          msg = "Böyle bir mail kayıtlı değil";
                                        }
                                        if (e.code == 'invalid-email') {
                                          msg = "Hatalı mail girişi";
                                        }
                                        if (e.code == 'wrong-password') {
                                          msg = "Parola yanlış veya hatalı";
                                        }
                                        dialogMesaj(context, msg: msg);
                                      }
                                    }
                                  },
                                  text: 'Giriş Yap'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Hesabın yok mu?'),
                                  MainTextButton(
                                      TextYazisi: 'Kayıt Ol',
                                      Press: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPages(),
                                          ),
                                        );
                                      },
                                      size: 20)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogMesaj(BuildContext context, {String msg = ''}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hata"),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Kapat"),
          ),
        ],
      ),
    );
  }
}
