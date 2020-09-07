import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shesha/API/Login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget loading = Text(
    'دخول',
    style: TextStyle(color: Colors.black, fontSize: 24.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '+966',
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          )),
                          fillColor: Colors.white24,
                          filled: true)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'رقم الهاتف',
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(4.0),
                          )),
                          fillColor: Colors.white24,
                          filled: true)),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    loading = CircularProgressIndicator();
                  });
                  return Login().login("0596610095");
                },
                child: Container(
                  child: Center(child: loading),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
