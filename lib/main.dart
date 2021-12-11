import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:test_run/area.dart';
import 'package:test_run/ipcon.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_run/register.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluuter Login',
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{},
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Login() async {
    var url = 'http://$ipcon/test/login.php';
    var response = await http.post(Uri.parse(url),
        body: {'user_email': email.text, 'user_password': password.text});
    var data = json.decode(response.body);
    if (data != 'Error') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('userid', data[0]['user_id']);
      // if (data[0]['user_type'] == 'admin') {
      //   setState(() {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Area(),
      //       ),
      //     );
      //   });
      // } else {
      //   //home for user
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Area(),
            ),
          );
        });
      // }
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Username หรือ Password ผิดค่ะ",
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Login",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Please Login !',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10, bottom: 10),
                            child: TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 180),
                            child: GestureDetector(
                                child: Text("Forgot Password?",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 50,
                            width: 150,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.teal, // background
                              textColor: Colors.white, // foreground
                              onPressed: () {
                                Login();
                              },
                              child: Text('Login'),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Divider(
                      thickness: 2,
                      color: Colors.white,
                      height: 15,
                    ),
                  ),
                  Text('Create your Account?'),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.teal, // background
                      textColor: Colors.white, // foreground
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
