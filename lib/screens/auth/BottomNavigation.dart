import 'package:flutter/material.dart';
import 'package:testings/screens/home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController pageController = PageController();
  int _selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xff8A00FF),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined),
              label: 'Transaction',
              backgroundColor: Colors.brown,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Locker',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink,
            ),
          ],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: onTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple,
        ),
        body: PageView(
          controller: pageController,
          children: [
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
