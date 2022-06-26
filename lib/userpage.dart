import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melike_project/listadd.dart';
import 'package:melike_project/loginpage.dart';

class UserPages extends StatefulWidget {
  const UserPages({Key? key}) : super(key: key);

  @override
  State<UserPages> createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  String mevcutkullaniciUIDTutucu = "";
  bool harfSiralama = false;

  @override
  void initState() {
    KullaniciUIDAl();
    super.initState();
  }

  KullaniciUIDAl() async {
    FirebaseAuth yetki = FirebaseAuth.instance;
    final mevcutkullanici = await yetki.currentUser!;

    setState(() {
      mevcutkullaniciUIDTutucu = mevcutkullanici.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2c0c0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: const Color(0xFFCF7751),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPages(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.logout),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/3.png'),
                        const SizedBox(height: 25),
                        const Text('Hoşgeldin cnm'),
                      ],
                    ),
                  ),
                  //sistem saatine göre mesaj yazdırma
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 15),
                      sytemClock(),
                    ],
                  ),
                  //sistem saatine göre mesaj yazdırma
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        ' Tasks List',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Günlük görevler',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  harfSiralama = !harfSiralama;
                                });
                              },
                              icon: Icon(
                                Icons.abc,
                                color: harfSiralama ? Colors.red : Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListEkleme()),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text sytemClock() {
    final dtt = DateTime.now();
    String textYazisi = '';
    if (dtt.hour < 11) {
      textYazisi = "Günaydın";
    }
    if (dtt.hour < 16) {
      textYazisi = "İyi Günler";
    } else {
      textYazisi = "İyi akşamlar";
    }

    return Text(
      '$textYazisi ',
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
