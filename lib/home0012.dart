import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'HomePage001.dart';
import 'Profile.dart';
import 'Request.dart';
import 'comerequests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail currentrequest.dart';
import 'showmorerequesr.dart';


class MyHomePage001 extends StatefulWidget {
  final String userId;
  final String userEmail;

  MyHomePage001(this.userId, this.userEmail);
  @override
  _MyHomePage001State createState() => _MyHomePage001State();
}

class _MyHomePage001State extends State<MyHomePage001> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static List<Widget> _widgetOptions(MyHomePage001 widget) => <Widget>[
    HomePage001(widget.userId, widget.userEmail),
    SubmitFormPage(widget.userId, widget.userEmail),
    // SettingsPage(),
    Comerequest(widget.userId,widget.userEmail),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 187, 18, 18),
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      body: Stack(
        children: [

          _buildPageTransition(),
          if (_isMenuOpen) _buildSideMenu(),

        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.request_page, size: 30),

          Icon(Icons.notifications,size: 30,),
          Icon(Icons.account_circle_outlined, size: 30),
        ],
        color: Colors.red,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPageTransition() {
    List<Widget> widgets = _widgetOptions(widget);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(_isMenuOpen ? 0.6 : _selectedIndex == 0 ? 0 : 1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        )),
        child: widgets[_selectedIndex],
      ),
    );
  }

  Widget _buildSideMenu() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      )),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                _onItemTapped(0);
                _toggleMenu(); // Close menu after selecting option

              },

            ),
            ListTile(
              title: Text('Request'),
              onTap: () {
                _onItemTapped(1);
                _toggleMenu(); // Close menu after selecting option

              },
            ),
            ListTile(
              title: Text('Received requests'),
              onTap: () {
                _onItemTapped(2);
                _toggleMenu(); // Close menu after selecting option
              },
            ),
          ],
        ),
      ),
    );
  }

}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}


