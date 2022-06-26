import 'package:flutter/material.dart';

class UserPages extends StatefulWidget {
  const UserPages({Key? key}) : super(key: key);

  @override
  State<UserPages> createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc2c0c0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('Selam'),
            ],
          ),
        ),
      ),
    );
  }
}
