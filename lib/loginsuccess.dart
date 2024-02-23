import 'package:flutter/material.dart';

class LoginSuccessful extends StatelessWidget {
  const LoginSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Login Successful!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          )
        ])));
  }
}
