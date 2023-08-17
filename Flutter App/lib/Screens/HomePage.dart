import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/Screens/DisplayImage.dart';
import 'package:gp/providers/AuthService.dart';
import 'package:gp/widgets/AdminBottomBar.dart';
import 'package:sizer/sizer.dart';
import 'package:gp/widgets/DeafultButton.dart';
import '../Constants/AppColours.dart';
import '../widgets/BottomBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
  static bool isLoading = true;
  static String category = '';
  static bool isAdmin = false;
}

class _HomePage extends State<HomePage> {
  void initState() {
    super.initState();
    DisplayImage.text = '';
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        AuthService.Email = user.uid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Drawer(
        //   child:Column(
        //     children: [
        //       ListTile(
        //         leading: Icon(Icons.account_circle_outlined,color: Colors.black),
        //         title:  Text('Contacts'),
        //         onTap: () {
        //           Navigator.of(context).pushNamed('/Contacts');
        //
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar:
            HomePage.isAdmin == true ? AdminBottomBar() : BottomBar(),
        backgroundColor: AppColours.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(2.w, 7.h, 2.w, 3.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 3.w),
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                DisplayImage.text = value;
                              });
                            },
                            style: TextStyle(color: AppColours.textColor),
                            maxLines: 8,
                            decoration: InputDecoration(
                              fillColor: AppColours.widgetColor,
                              hintText: HomePage.category == "Wedding Dress"
                                  ? "Off-the-shoulder straps dip down into "
                                      "a flattering sweetheart neckline and fitted bodice with architectural"
                                      " contour seaming and bow belt detail to highlight the figure."
                                  : HomePage.category == "Casual"
                                      ? "Space war hoodie"
                                      : "Imagine a dress design here...",
                              hintStyle: TextStyle(
                                  color: Colors.black45, fontSize: 15.sp),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 5, color: AppColours.color),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )),
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.w),
                        child: Text(
                          "Choose category",
                          style: TextStyle(
                            color: AppColours.textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                Container(
                    height: 53.w,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Container(
                              decoration: new BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: HomePage.category == "Wedding Dress"
                                        ? Colors.amber
                                        : Colors.black87),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(20.0)),
                                shape: BoxShape.rectangle,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        HomePage.category = "Wedding Dress";
                                      });
                                    },
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Image(
                                            width: 150,
                                            height: 250,
                                            image: AssetImage(
                                                'assets/Wedding Dress.png'),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.black87,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 20.0,
                                                ),
                                              ],
                                            ),
                                            child: GridTileBar(
                                                title: Text("Wedding Dress",
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))),
                                          ),
                                        ]),
                                  )))),
                      Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Container(
                              decoration: new BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: HomePage.category == "Casual"
                                        ? Colors.amber
                                        : Colors.black87),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(20.0)),
                                shape: BoxShape.rectangle,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        HomePage.category = "Casual";
                                      });
                                    },
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Image(
                                            width: 150,
                                            height: 250,
                                            image: AssetImage(
                                                'assets/General.jpg'),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.black87,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 20.0,
                                                ),
                                              ],
                                            ),
                                            child: GridTileBar(
                                                title: Text("Casual",
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))),
                                          ),
                                        ]),
                                  )))),
                    ])),
                SizedBox(height: 2.h),
                DefultButton(
                  text: "Submit",
                  toWhere: '/image',
                  nwAT: 'home',
                ),
              ],
            )));
  }
}

//sk-bqvENEQ8pWbLxQy1YUI0w1F10gFK4hvpiwJo1tp6QDy10qsG
