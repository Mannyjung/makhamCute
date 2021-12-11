import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_run/area.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<StatefulWidget> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  int _selectIndex = 0;
  List<Widget> _pageWidget = <Widget>[Area()];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('พื้นที่', style: GoogleFonts.prompt(),), backgroundColor: Colors.grey),
  ];
  void _onItemTapper(int index){
    setState(() {
      _selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapper,
      ),
    );
  }
}

