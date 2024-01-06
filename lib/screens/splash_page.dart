import 'dart:async';
import 'dart:io';
import 'package:MyInv_flutter/screens/auth/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Create the VideoPlayerController instance
    _controller = VideoPlayerController.asset('assets/Splash.mp4');

    // Initialize the video player
    _initializeVideo();
  }

  void _initializeVideo() async {
    // Wait for the video player to initialize
    if(_controller.value.isInitialized){
      print("initialized");
        // Ensure the first frame is shown after the video is initialized
      if(!_controller.value.isPlaying){
        print("not playing");
        _controller.setLooping(false);
        _controller.setVolume(0.5);
        setState(() {
          _visible = true;
        });

        // Play the video
        await Future.delayed(Duration(seconds: 2), () {
          _controller.play();
         /* Timer.periodic(Duration(milliseconds: 1000), (timer) {
            if(_controller.value.isCompleted)
              timer.cancel();
            setState(() {\
            });
          });*/
        });
        _initializeVideo();
      }else{
        print("Playing");
        _controller.addListener(_onVideoCompleted);
      }
    }
    else{
      print("not initialized");
      await _controller.initialize().then((value) => _initializeVideo());
    }
  }

  void _onVideoCompleted() {
    // Wait for the video to complete
    Future.delayed(Duration(seconds: 2), () {
      if (_controller.value.isCompleted) {
        // Pause the video
        _controller.pause();
        // Hide the video
        setState(() {
          _visible = false;
        });
        // Navigate to the next page
        Future.delayed(Duration(seconds: 2), () {
          navigationPage();
          // Dispose the VideoPlayerController instance to avoid conflicts with hot reload

        });
      }
    });
  }

  @override
  void dispose() {

    super.dispose();
    // Dispose the VideoPlayerController instance when the widget is disposed
    _controller.dispose();

  }


  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: AspectRatio(
          aspectRatio:1,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
    this.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey.withOpacity(0.42),
          body: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      alignment: Alignment.center,
                      child: _getVideoBackground(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0,right: 10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Made by '),
                            TextSpan(
                              text: 'Daoud El Bayah',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
    );
  }*/

/* _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }*/
