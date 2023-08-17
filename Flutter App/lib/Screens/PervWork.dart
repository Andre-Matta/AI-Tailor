import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gp/Constants/AppColours.dart';
import 'package:gp/providers/DataBase.dart';
import 'package:gp/widgets/BottomBar.dart';
import 'package:gp/widgets/PrevWorkWidget.dart';
import 'package:sizer/sizer.dart';

class PrevWork extends StatefulWidget {
  @override
  _PrevWorkState createState() => _PrevWorkState();
}

class _PrevWorkState extends State<PrevWork> {
  bool isLoading = true;
  void initState() {
    super.initState();
    if (DataBase.history.isEmpty) {
      DataBase.getItem().then((value) => {
            if (mounted)
              setState(() {
                isLoading = false;
              })
          });
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      backgroundColor: AppColours.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(children: [
              Container(height: 30.h, child: Image.asset('assets/history.png')),
              Expanded(
                  child: ListView.builder(
                      itemCount: DataBase.history.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PrevWorkWid(item: DataBase.history[index]);
                      }))
            ]),
    );
  }
}
