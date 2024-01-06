
import 'package:MyInv_flutter/app_properties.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../AlertDialogs/errorLoginDialog.dart';
import '../../AlertDialogs/notImplementedDialog.dart';
import '../../models/Person.dart';
import '../intro_page.dart';
import '../main/main_page.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final Dio dio = Dio(BaseOptions(receiveDataWhenStatusError: true,validateStatus: (status) { return status! < 500; }));
  TextEditingController email = TextEditingController();
  List<Color> colors=[Colors.blueGrey,Colors.blueGrey,Colors.blueGrey];
  TextEditingController password = TextEditingController();
  bool _showPassword=false;

  @override
  void initState() {
    super.initState();
    dio.options.extra['withCredentials'] = true;
    dio.options.receiveDataWhenStatusError=true;
    checkLogin();
  }

  Future<void> checkLogin() async {
    String url="";
    kIsWeb? url="http://localhost/MyInv/auth/check_login.php":url="http://10.0.2.2/MyInv/auth/check_login.php";
    print("before response");
    try {
      var response = await dio.get(url);
      print("after response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Session is set, navigate to MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      print('after response with error');
      print(error);
      }
  }
  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Welcome',
      style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
        child: Text(
          'Login to your account using\nEmail address',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = Positioned(
      right: MediaQuery.of(context).size.width / 12,
      bottom: 40,
      child: Material(
        elevation: 6, // Adding elevation to the button
        borderRadius: BorderRadius.circular(9.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(106, 142, 154, 0.4),
                Color.fromRGBO(52, 101, 91, 0.4),
                Color.fromRGBO(92, 129, 120, 0.4),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            ),
            borderRadius: BorderRadius.circular(9.0),
            border: Border.all(color:colors[0],width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(9.0),
            mouseCursor: SystemMouseCursors.click,
            onHover: (b) {
              setState(() {
                colors[0] = b ? Color.fromRGBO(220, 202, 146, 0.92) : Colors.blueGrey;
              });
            },
            onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RegisterPage()));
            },
            child: Container(
              width: 100,
              height: 65,
              child: Center(
                child: Text(
                  "Register",
                  style: GoogleFonts.openSans(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget loginButton = Positioned(
      right: MediaQuery.of(context).size.width / 12 + 100 + 25,
      bottom: 40,
      child: Material(
        elevation: 6, // Adding elevation to the button
        borderRadius: BorderRadius.circular(9.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(106, 142, 154, 0.4),
                Color.fromRGBO(52, 101, 91, 0.4),
                Color.fromRGBO(92, 129, 120, 0.4),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            ),
            borderRadius: BorderRadius.circular(9.0),
            border: Border.all(color:colors[1],width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(9.0),
            mouseCursor: SystemMouseCursors.click,
            onHover: (b) {
              setState(() {
                colors[1] = b ? Color.fromRGBO(220, 202, 146, 0.92) : Colors.blueGrey;
              });
            },
            onTap: () async{
              if (await Person.login(email.text, password.text)) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => IntroPage()));
              }else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorLoginDialog();
                    });
              }
            },
            child: Container(
              width: 100,
              height: 65,
              child: Center(
                child: Text(
                  "Log In",
                  style: GoogleFonts.openSans(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Widget loginForm = Container(
      height: 255,
      child: Stack(
        children: <Widget>[
          Container(
            height: 225,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.42),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: TextField(
                    controller: email,
                    style: GoogleFonts.openSans(fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: "Enter Username/Email",
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular((10))
                            )
                        )
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: GoogleFonts.openSans(fontSize: 16.0),
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          /*Row(children: [*/
            loginButton,registerButton
          /*],)*/
        ],
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(top:10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: GoogleFonts.openSans(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
            },
            onHover: (b) {
              setState(() {
                colors[2] = b ? Colors.lightBlueAccent : Colors.blueGrey;
              });
            },
            child: Text(
              'Reset Password',
              style: GoogleFonts.openSans(
                decoration: TextDecoration.underline,
                color: colors[2],
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in using',
          style: GoogleFonts.openSans(fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.google,size:20,color:Colors.white),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NotImplementedDialog();
                    });
              },
              color: Colors.white,
            ),
            IconButton(
                icon: Icon(Icons.facebook),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NotImplementedDialog();
                      });
                },
                color: Colors.white),
          ],
        )
      ],
    );
    return Scaffold(

      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.42),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                loginForm,
                Spacer(flex: 2),
                forgotPassword,
                Spacer(flex: 2),
                socialRegister
              ],
            ),
          )
        ],
      ),
    );
  }
}
