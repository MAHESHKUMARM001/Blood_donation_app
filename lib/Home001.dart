import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'Request.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;

  final List<Widget> _pages = [
    _buildPage(Colors.blue),
    _buildPage(Colors.green),
    _buildPage(Colors.orange),
    _buildPage(Colors.red),
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
        title: Text('Your App Title'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
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
          IconButton(
            icon: Icon(Icons.home, size: 30),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(Icons.request_page, size: 30),
            onPressed: () => _onItemTapped(1),

          ),

          IconButton(
            icon: Icon(Icons.notifications, size: 30),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(Icons.settings, size: 30),
            onPressed: () => _onItemTapped(3),
          ),
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
        child: _pages[_selectedIndex],
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
              title: Text('Menu 1'),
              onTap: () {
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: Text('Menu 2'),
              onTap: () {
                _onItemTapped(1);
              },
            ),
            ListTile(
              title: Text('Menu 3'),
              onTap: () {
                _onItemTapped(2);
              },
            ),
            ListTile(
              title: Text('Menu 4'),
              onTap: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildPage(Color color) {
    return Container(
      color: color,
    );
  }
}