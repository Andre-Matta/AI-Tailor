import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/Constants/AppColours.dart';
import 'package:flutter/material.dart';
import 'package:gp/Screens/HomePage.dart';
import 'package:gp/providers/AuthService.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/Logo.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _padddown;
  Animation<double>? _size;
  double? down;

  @override
  void initState() {
    super.initState();
    HomePage.isAdmin = false;
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _controller!.forward();

    _padddown = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 0), weight: 1),
      // TweenSequenceItem<double>(tween: Tween(begin: 0, end: 400), weight: 1)
    ]).animate(_controller!);

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            print('User is currently signed out!');
            Navigator.pushReplacementNamed(context, '/Login');
          } else {
            print('User is signed in!');
            // AuthService.Email = user.email;
            if (user.uid == "lqiH5q50vyLgfe0z2TLhMP1RuwC2") {
              HomePage.isAdmin = true;
            }
            Navigator.pushReplacementNamed(context, '/Home');
          }
        });
        //Navigator.pushReplacementNamed(context, '/Login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, _) {
        return Container(
          color: HexColor("#10110e"),
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, _padddown!.value),
              child: Logo()),
        );
      },
    );
  }
}
