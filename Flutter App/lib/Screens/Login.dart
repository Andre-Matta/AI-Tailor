import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/Screens/HomePage.dart';
import 'package:gp/providers/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:sizer/sizer.dart';
import '../widgets/Logo.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  @override
  void initState() {
    super.initState();
    HomePage.isAdmin = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('User is signed in!');
        Navigator.pushReplacementNamed(context, '/Home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#10110e"),
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.w, 1.w, 1.w, 1.w),
                    child: Logo(),
                  ),
                  SignInButton(
                    buttonSize: ButtonSize.large,
                    buttonType: ButtonType.google,
                    onPressed: () async {
                      try {
                        await AuthService().signInWithGoogle().then((value) => {
                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) {
                                print('User is signed in!');
                                if (user!.uid ==
                                    "lqiH5q50vyLgfe0z2TLhMP1RuwC2") {
                                  HomePage.isAdmin = true;
                                }
                                Navigator.pushReplacementNamed(
                                    context, '/Home');
                              })
                            });

                        Navigator.pushReplacementNamed(context, '/Home');
                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          print(e.message!);
                        }
                      }
                    },
                  ),
                  SizedBox(height: 7.h),
                ],
              ),
            ),
          ),
          onWillPop: () {
            // Widget okButton = FlatButton(
            //     child: Text("Yes"),
            //     onPressed: () {
            //       exit(0);
            //     });
            // Widget cancelButton = FlatButton(
            //     child: Text("cancel"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15)),
                    title: Text("Exit"),
                    content: Text("Are you sure you want to exit?"),
                    //actions: [okButton, cancelButton],
                  );
                });
            Future<bool>? c;
            return c!;
          },
        ));
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
