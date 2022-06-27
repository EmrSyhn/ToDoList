import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melike_project/listadd.dart';
import 'package:melike_project/loginpage.dart';

import 'components/analogClock.dart';
import 'components/mainiconbutton.dart';

class UserPages extends StatefulWidget {
  const UserPages({Key? key}) : super(key: key);

  @override
  State<UserPages> createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  String mevcutkullaniciUIDTutucu = "";
  @override
  void initState() {
    kullaniciUidAl();
    super.initState();
  }

  kullaniciUidAl() async {
    FirebaseAuth yetki = FirebaseAuth.instance;
    final mevcutKullanici = await yetki.currentUser!;
    setState(() {
      mevcutkullaniciUIDTutucu = mevcutKullanici.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc2c0c0),
        toolbarHeight: 40,
        actions: [
          MainIconButton(
            iconsecici: Icons.logout,
            press: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPages(),
                ),
              );
            },
          )
        ],
      ),
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
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/3.png'),
                        const SizedBox(height: 25),
                        const Text('Hoşgeldin '),
                      ],
                    ),
                  ),
                  //sistem saatine göre mesaj yazdırma
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 35),
                      sytemClock(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      AnalogSaat(),
                    ],
                  ),
                  //sistem saatine göre mesaj yazdırma
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        ' Görev Listeleri',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Görevler',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListAdd()),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('taskLists')
                                .doc(mevcutkullaniciUIDTutucu)
                                .collection('myList')
                                .snapshots(),
                            builder: (context, veriTabaniVerilerim) {
                              if (veriTabaniVerilerim.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                final alinanVeri =
                                    veriTabaniVerilerim.data!.docs;
                                return ListView.builder(
                                  itemCount: alinanVeri.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: const Color(0xffc2c0c0),
                                      child: ListTile(
                                        title: Text(
                                          alinanVeri[index]['taskName'],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          alinanVeri[index]['myContents'],
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection('taskLists')
                                                .doc(mevcutkullaniciUIDTutucu)
                                                .collection('myList')
                                                .doc(alinanVeri[index].id)
                                                .delete();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
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
    if (dtt.hour < 14) {
      textYazisi = "Tünaydın";
    }
    if (dtt.hour < 18) {
      textYazisi = "İyi Günler";
    }
    if (dtt.hour < 21) {
      textYazisi = "İyi Akşamlar";
    } else {
      textYazisi = "İyi Geceler";
    }

    return Text(
      '$textYazisi ',
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
