import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 9.h),
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image(
            image: AssetImage('assets/tailor.png'),
          ),
        ),
      ),
    );
  }
}
