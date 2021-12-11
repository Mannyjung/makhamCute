import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_run/ipcon.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController user_name = TextEditingController();
  TextEditingController user_email_phone = TextEditingController();
  TextEditingController user_password = TextEditingController();
  TextEditingController user_repassword = TextEditingController();

  String statuser = "1";
  File? _images;
  void register() async {
    // print(user_name.text);
    // print(user_email_phone.text);
    // print(user_password.text);

    final uri = Uri.parse("http://$ipcon/test/insert_user.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['user_name'] = user_name.text;
    request.fields['user_email_phone'] = user_email_phone.text;
    request.fields['user_password'] = user_password.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Upload');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('statuser', statuser);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      print('Image Not Uploded');
      print(response.statusCode);
    }
  }

  void Getimage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(Icons.add),
    );
    setState(() {
      _images = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          // height: 500,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 165),
                child: Text(
                  'ลงทะเบียน',
                  style: GoogleFonts.kanit(fontSize: 24),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              child: TextFormField(
                                validator: RequiredValidator(
                                          errorText: 'กรุณากรอกให้ถูกต้อง'),
                                controller: user_email_phone,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'เบอร์โทร หรือ email',
                                    hintStyle: GoogleFonts.kanit(fontSize: 16)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              child: TextFormField(
                                 controller: user_password,
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'รหัสผ่าน',
                                    hintStyle: GoogleFonts.kanit(fontSize: 16)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              child: TextFormField(
                                obscureText: true,
                                 controller: user_repassword,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'ยืนยันรหัสผ่าน',
                                    hintStyle: GoogleFonts.kanit(fontSize: 16)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              child: TextFormField(
                                 controller: user_name,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'ชื่อผู้ใช้',
                                    hintStyle: GoogleFonts.kanit(fontSize: 16)),
                              ),
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
                                  register();
                                },
                                child: Text('ลงทะเบียน',
                                    style: GoogleFonts.kanit(fontSize: 16)),
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
