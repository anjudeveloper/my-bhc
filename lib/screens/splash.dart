import 'dart:async';

import 'package:black_history_calender/const/colors.dart';
import 'package:black_history_calender/helper/prefs.dart';
import 'package:black_history_calender/screens/auth/provider/auth_provider.dart';
import 'package:black_history_calender/screens/home/home_screen.dart';
import 'package:black_history_calender/screens/welcome_screen.dart';
import 'package:black_history_calender/services/auth_services.dart';
import 'package:black_history_calender/services/loca_auth_api.dart';
import 'package:black_history_calender/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required Key key, required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  bool remember = false;
  bool touchID = false;
  final AuthBase auth = Auth();

  @override
  void initState() {
    // PushNotificationsManager().init();
    super.initState();
    initData();
  }

  initData() async {
    await Prefs.rememberMe.then((value) {
      if (value != null) {
        setState(() {
          remember = value;
        });
      }
    });

    await Prefs.token.then((value) {
      if (value != null) {
        setState(() {
          token = value;
        });
      }
    });

    await Prefs.manageTouch.then((value) => setState(() {
          touchID = value;
        }));

    if (touchID) {
      await _biofunction(touchID);
    }

    if (remember != null && remember && token != null && token.isNotEmpty) {
      Timer(
          Duration(seconds: 3),
          () =>   Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(auth: widget.auth)),
              ModalRoute.withName('')
          )
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () =>  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomeScreen(key: GlobalKey(),auth: widget.auth,)),
            ModalRoute.withName('')
        )
      );
    }
  }

  Future<void> _biofunction(switchValue) async {
    if (switchValue == true) {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        await validateToken();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => HomeScreen(
        //               auth: auth,
        //             )),
        //     ModalRoute.withName('/'));
        // if (token != null && token.isNotEmpty) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //       builder: (context) => HomeScreen(
        //             auth: auth,
        //           )),
        // );
        // } else {}
      }
    }
  }

  Future validateToken() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .checkTokenValidate(token)
        .then((value) {
      if (value!.code!.contains("jwt_auth_valid_token")) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(
                      auth: auth,
                    )),
            ModalRoute.withName(''));
        return;
      } else {
        showAlertDialog(
            context: context,
            title: "Alert",
            content: 'Session expired please login again',
            cancelActionText: "",
            defaultActionText: "OK",
            defaultFunc: () async {
              await Prefs().clear();
              await auth.signOut();
              Navigator.of(context).pop(true);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => WelcomeScreen(auth: widget.auth)),
              // );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WelcomeScreen(key: GlobalKey(),auth: widget.auth)),
                  ModalRoute.withName('')
              );
              return;
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: backGradient),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/images/bhc_logo.png',
                    ))),
                  ),
                  Text(
                    'My Black History Calendar\nis now YOURS!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: white,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: Center(
            //             child: Text('GET STARTED',
            //               style: TextStyle(
            //                   color: white,
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w500
            //               ),
            //       ),
            //           )),
            //       GestureDetector(
            //         onTap: (){
            //           Navigator.pushReplacement(context,
            //               MaterialPageRoute(builder:
            //                   (context)=>SignInScreen()));
            //         },
            //           child: Icon(Icons.arrow_forward, color: white,))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
