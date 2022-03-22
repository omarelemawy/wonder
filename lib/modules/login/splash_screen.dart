import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wander_guide/modules/home/home_layout.dart';
import 'package:wander_guide/modules/login/singin_screen.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

class FirstScreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<FirstScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
        seconds: 4,
        navigateAfterSeconds: nextPage(),
        title:  const Text('Wander guide',
          style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: Image.asset(
          'assets/wegather.png', height: 100, width: 190),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red
    );
  }

  String getToken() {
    return CacheHelper.getData(key: "remember_token");
  }

  Widget nextPage() {
    Widget widget;
    if (getToken() != null) {
      print(getToken().toString());
      widget =  HomeLayout();
    } else {
      widget = SignInScreen();
    }
    return widget;
  }


}