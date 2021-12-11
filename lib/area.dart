import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Area extends StatelessWidget {
  const Area({Key? key}) : super(key: key);
  Widget para(){
    return Image.asset('assets/rubber.jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 110),
                child: Text(
                  'พื้นที่',
                  style: GoogleFonts.prompt(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: Ink(
                child: IconButton(
                    onPressed: null,
                    icon: const Icon(Icons.add),
                    color: Colors.white),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        style: GoogleFonts.prompt(
                            fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 20, bottom: 5, right: 20),
                            border: InputBorder.none,
                            hintText: 'ค้นหาพื้นที่',
                            hintStyle: GoogleFonts.prompt(fontSize: 16)),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 20, bottom: 5, right: 20),
                      child: ListTile(
                        title: Text('สวนยางพารา'),
                        subtitle: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('พืช: ยางพารา'),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('ช่วงชีวิต: ออกดอก'),
                            ),
                          ],
                        ),
                        trailing: para(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
