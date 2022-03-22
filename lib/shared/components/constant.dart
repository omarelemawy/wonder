import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wander_guide/modules/login/register.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: "token").then((value) {
    pushAndRemove(context,SignUpScreen());
  }
  );
}

void pushAndRemove(context,widget)
{
  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
      (context)=>widget), (route) => false);
}
void push(context,widget){
  Navigator.push(context,MaterialPageRoute(builder:
      (context)=>widget));
}