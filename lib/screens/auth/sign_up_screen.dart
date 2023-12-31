import 'package:black_history_calender/const/colors.dart';
import 'package:black_history_calender/helper/prefs.dart';
import 'package:black_history_calender/screens/auth/model/signup_response.dart';
import 'package:black_history_calender/screens/auth/provider/auth_provider.dart';
import 'package:black_history_calender/screens/auth/sign_in_screen.dart';
import 'package:black_history_calender/screens/home/home_screen.dart';
import 'package:black_history_calender/widget/snackbar_widget.dart';
import 'package:black_history_calender/widget/text_field_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _firstFocus = new FocusNode();
  FocusNode _lastFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passFocus = new FocusNode();

  late String token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        //keyboard pop-down
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(gradient: backGradient),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/images/bhc_logo.png',
                    ))),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Sign up',
                        style: GoogleFonts.montserrat(
                            color: Color(0xff666666),
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldSideBorder(
                        tfieldController: _firstNameController,
                        focus: _firstFocus,
                        hint: "First name",
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldSideBorder(
                        tfieldController: _lastNameController,
                        focus: _lastFocus,
                        hint: "Last name",
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldSideBorder(
                        tfieldController: _emailController,
                        focus: _emailFocus,
                        hint: "Email",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldSideBorder(
                        tfieldController: _passwordController,
                        focus: _passFocus,
                        hint: "Password",
                        icon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => signup(),
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xff0891d9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            },
                            child: Text(
                              'Sign In Now',
                              style: TextStyle(
                                  color: lightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }

  Future signup() async {
    EasyLoading.show(dismissOnTap: false);
    var response = await Provider.of<AuthProvider>(context, listen: false)
        .signupUser(
            _emailController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
            "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
            _firstNameController.text.trim(),
            _lastNameController.text.trim());

    if (response != null && response.code == 200) {
      EasyLoading.dismiss();
      CommonWidgets.buildSnackbar(context, "Signup successful");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      EasyLoading.dismiss();
      // CommonWidgets.buildSnackbar(context, response.message);
      CommonWidgets.buildSnackbar(context, response!.message!);

    }
  }
}
