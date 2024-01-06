import 'package:MyInv_flutter/AlertDialogs/errorConfirmPassDialog.dart';
import 'package:MyInv_flutter/screens/auth/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../AlertDialogs/notImplementedDialog.dart';
import '../../models/Person.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cmfPassword = TextEditingController();
  Color color = Colors.blueGrey;
  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'You Are About To Register!',
      style: TextStyle(
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
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));
    Widget registerButton = Positioned(
      right: MediaQuery.of(context).size.width / 12,
      bottom: 0,
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
            border: Border.all(color: color, width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(9.0),
            mouseCursor: SystemMouseCursors.click,
            onHover: (b) {
              setState(() {
                color =
                    b ? Color.fromRGBO(220, 202, 146, 0.92) : Colors.blueGrey;
              });
            },
            onTap: () async {
              if (await Person.signUp(username.text,email.text, password.text, cmfPassword.text))
                Navigator.of(context).push(MaterialPageRoute(builder: (b) {
                  return LoginPage();
                }));
              else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorConfirmPassDialog();
                    });
              }
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

    Widget registerForm = Container(
      height: 365,
      child: Stack(
        children: <Widget>[
          Container(
            height: 315,
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
                    controller: username,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((10)))),
                        hintText: "Enter Username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: email,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((10)))),
                        hintText: "Enter Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((10))))),
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: cmfPassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((10)))),
                        hintText: "Confirm Password"),
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          registerButton,
        ],
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in using',
          style: GoogleFonts.openSans(
              fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(FontAwesomeIcons.google, size: 20, color: Colors.white),
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
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                title,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                registerForm,
                Spacer(flex: 2),
                Padding(
                    padding: EdgeInsets.only(bottom: 20), child: socialRegister)
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
