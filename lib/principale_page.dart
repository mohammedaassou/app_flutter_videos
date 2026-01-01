import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_project_exam/pages/home_page.dart';
import 'package:flutter_project_exam/pages/profile_page.dart';
import 'package:flutter_project_exam/pages/video_search_page.dart';
import 'package:flutter_project_exam/pages/repos_page.dart';

class Principalpage extends StatefulWidget {
  const Principalpage({super.key});

  @override
  State<Principalpage> createState() => _PrincipalpageState();
}

class _PrincipalpageState extends State<Principalpage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> screens = [
    HomePage(),
    VideoSearchPage(),
    ReposPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.video_camera_back, size: 30),
          Icon(Icons.info, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: screens[_page],
    );
  }
}
