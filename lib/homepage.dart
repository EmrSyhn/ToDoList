// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'components/Button.dart';
import 'loginpages.dart';

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
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPages(),
                        ),
                      );
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
