import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../AlertDialogs/notImplementedDialog.dart';

class ConfirmOtpPage extends StatefulWidget {
  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  TextEditingController pinEditingController = TextEditingController();
  late bool _showResend;
  late Timer _timer;
  String txtTime='00:59';
  Widget? footer=null;
  Widget? resendAgainText;
  Color color=Colors.blueGrey;
  void initState() {
    super.initState();
    _showResend = false;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int i = int.parse(txtTime.split(':')[1]);
        if (i <= 0) {
          _showResend = true;
          _timer.cancel();
        } else {
          if (i < 10)
            txtTime = '00:0${i - 1}';
          else
            txtTime = '00:${i - 1}';
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Widget Title = Padding(padding:EdgeInsets.only(right:28,),
        child:Text(
      'OTP Confirmation',
      style: TextStyle(
          color: Colors.white.withOpacity(1.0),
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(1, 6),
              blurRadius: 10.0,
            )
          ]),
    ));

    Widget SubTitle = Padding(
        padding: const EdgeInsets.only(
            right: 28.0
        ),
        child: Text(
          'Please wait, we are sending your OTP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget verifyButton = Material(
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
            border: Border.all(color:color,width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(9.0),
            mouseCursor: SystemMouseCursors.click,
            onHover: (b) {
              setState(() {
                color= b ? Color.fromRGBO(220, 202, 146, 0.92) : Colors.blueGrey;
              });
            },
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NotImplementedDialog();
                  });
            },
            child: Container(
              width: 200,
              height: 65,
              child: Center(
                  child: new Text("Verify",
                      style: const TextStyle(
                          color: const Color(0xfffefefe),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0))),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(236, 60, 3, 1),
                        Color.fromRGBO(234, 60, 3, 1),
                        Color.fromRGBO(216, 78, 16, 1),
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                      offset: Offset(0, 5),
                      blurRadius: 10.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(9.0)),
            ),
          ),
        ),
    );

    Widget resendText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Resend again after ",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(255, 255, 255, 0.5),
            fontSize: 14.0,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            txtTime,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
    resendAgainText = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: _showResend
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Didn't receive the OTP? ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _showResend = false;
                txtTime = '00:59'; // Reset timer
              });
              _startTimer();
              // Perform resend action here
            },
            child: Text(
              'Resend again',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      )
          : SizedBox.shrink(),
    );

    footer = _showResend ? resendAgainText : resendText;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.42)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Stack(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(flex: 3),
                      Center(child:Title),
                      Spacer(),
                      Center(child:SubTitle),
                      Spacer(flex: 1),
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: PinCodeTextField(
                              pinTextStyle: TextStyle(color:Colors.black),
                              controller: pinEditingController,
                              highlightColor: Colors.black,
                              highlightAnimation: true,
                              highlightAnimationBeginColor: Colors.white,
                              highlightAnimationEndColor: Theme.of(context).primaryColor,
                              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 500),
                              wrapAlignment: WrapAlignment.center,
                              hasTextBorderColor: Colors.transparent,
                              highlightPinBoxColor: Colors.white,
                              autofocus: true,
                              pinBoxHeight: 60,
                              pinBoxWidth: 60,
                              pinBoxRadius: 5,
                              defaultBorderColor: Colors.transparent,
                              pinBoxColor: Color.fromRGBO(255, 255, 255, 0.8),
                              maxLength: 4,
                              onDone: (pin) {
                                showDialog(context: context, builder: (builder){return NotImplementedDialog();});
                              },
                            ),
                          ),
                        ),
                      Spacer(flex: 1),
                      Center(child:Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: verifyButton,
                      )
                      ),
                      Spacer(flex: 2),
                      footer!,
                      Spacer()
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
