import 'package:flutter/material.dart';
import 'package:panda_biru/data/navbar_icon.dart';
import 'package:panda_biru/screen/activity_screen.dart';
import 'package:panda_biru/screen/home_screen.dart';
import 'package:panda_biru/screen/profile_screen.dart';
import 'package:panda_biru/theme/theme_color.dart';

class NavBar extends StatefulWidget {
  final String username;
  final int initialIndex; 

  const NavBar({
    super.key,
    required this.username,
    this.initialIndex = 0, 
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late List<Widget> halaman;
  late int selectedIndex; // default home

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // ambil dari parameter
    halaman = [
      HomeScreen(username: widget.username),
      const ActivityScreen(),
      const ProfileScreen(),
    ];
  }

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ThemeColor().whiteColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(NavBarImageIcon.home_NavbarIcon)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(NavBarImageIcon.activity_NavbarIcon)),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(NavBarImageIcon.profile_NavbarIcon)),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: ThemeColor().blueColor,
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: halaman,
      ),
    );
  }
}