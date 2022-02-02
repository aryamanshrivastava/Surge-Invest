import 'package:flutter/material.dart';
import 'package:testings/screens/auth/locker.dart';
import 'package:testings/screens/auth/profile.dart';
import 'package:testings/screens/auth/transaction.dart';
import 'package:testings/screens/home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController pageController = PageController();
  int _selectedIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0D104E),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0), ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Color(0xff473270),),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.change_circle_outlined,color: Color(0xff473270)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock,color: Color(0xff473270)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Color(0xff473270)),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffE4A951),
          ),
        ),
        body: PageView(
          controller: pageController,
          children: [
            HomeScreen(),
            Transaction(),
            Locker(),
            Profile(),
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
