import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/providers/DataBase.dart';
import 'package:gp/widgets/AdminBottomBar.dart';
import 'package:gp/widgets/FeedbackWidget.dart';
import 'package:sizer/sizer.dart';
import '../Constants/AppColours.dart';

class Feedbacks extends StatefulWidget {
  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  bool isLoading = true;
  void initState() {
    super.initState();
    if (DataBase.feedbacks.isEmpty) {
      DataBase.getFeedbacks().then((value) => {
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
      bottomNavigationBar: AdminBottomBar(),
      backgroundColor: AppColours.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: DataBase.feedbacks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FeedbackWidget(item: DataBase.feedbacks[index]);
                      }))
            ]),
    );
  }
}
