import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melike_project/userpage.dart';
import 'components/Button.dart';
import 'loginpage.dart';

//StatlessWidget'e geçildi
class Anasayfa extends StatelessWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2c0c0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 30, right: 30),
            //body içersinde boşluk verdim
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center),
                Image.asset('assets/images/1.png'),
                const SizedBox(height: 30),
                const Text(
                  'To Do Liste Başla',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                const Text('Görevlerini kaydet ve listelemeye başla'),
                const SizedBox(height: 100),
                MainButton(
                    press: () async {
                      //await FirebaseAuth.instance.signOut();

                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserPages(),
                          ),
                        );
                        // navigate to home page
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPages(),
                          ),
                        );
                        // log in
                      }
                    },
                    text: 'Kullanmaya Başla')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
