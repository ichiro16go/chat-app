import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'chatpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final result =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          userState.setUser(result.user!);
                          await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return ChatPage();
                          }));
                        } catch (e) {
                          setState(() {
                            infoText = "failed to register:${e.toString()}";
                          });
                        }
                      },
                      child: const Text('register'))),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final result = await auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          userState.setUser(result.user!);
                          await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return ChatPage();
                          }));
                        } catch (e) {
                          setState(() {
                            infoText = "failed to login:${e.toString()}";
                          });
                        }
                      },
                      child: const Text('login'))),
            ],
          ),
        ),
      ),
    );
  }
}
