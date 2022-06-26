import 'package:flutter/material.dart';

import 'homepage.dart';

/*Future<void>*/ main() {
  /*WidgetsFlutterBinding.ensureInitialized();*/
  /*await Firebase.initializeApp();*/
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Anasayfa();
  }
}
