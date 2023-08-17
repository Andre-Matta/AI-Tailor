import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gp/providers/AuthService.dart';
import 'package:sizer/sizer.dart';

class AdminBottomBar extends StatefulWidget {
  @override
  State<AdminBottomBar> createState() => _AdminBottomBar();
}

class _AdminBottomBar extends State<AdminBottomBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.feedback_outlined,
                text: 'Feedbacks',
              ),
              GButton(
                icon: Icons.logout,
                text: 'Logout',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              if (_selectedIndex == 0) {
                Navigator.of(context).pushReplacementNamed('/Home');
              } else if (_selectedIndex == 1) {
                AuthService().signOut().then((value) =>
                    Navigator.of(context).pushReplacementNamed('/feedback'));
              } else if (_selectedIndex == 2) {
                AuthService().signOut().then((value) =>
                    Navigator.of(context).pushReplacementNamed('/Login'));
              }
            },
          ),
        ),
      ),
    );
  }
}
