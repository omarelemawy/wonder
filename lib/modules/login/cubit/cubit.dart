import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/main.dart';
import 'package:wander_guide/modules/home/home_layout.dart';
import 'package:wander_guide/modules/login/cubit/states.dart';
import 'package:wander_guide/modules/login/reset_password.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';
import 'package:http/http.dart' as http;

import '../register.dart';
import '../singin_screen.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialShopStates());

  static RegisterCubit get(context) => BlocProvider.of(context);
  int changeScreensLogInIndex=0;
  Future<http.StreamedResponse> uploadFile(filePath, context, fname, lname,
      email, phone, password,description,type) async {
    print(type);
    emit(RegisterLoadingState());
    Map<String, String> postBody = {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'password': password,
      'type':type,
      "description":description
    };
    print(base64Encode(filePath.readAsBytesSync()));
    var APIURL = Uri.parse('https://wanderguide.net/api/register');
    var request =  http.MultipartRequest("POST", APIURL);
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'img', filePath.path);
    request.files.add(multipartFile);
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  SignInScreen()),(context)=>false);
        emit(RegisterSuccessState());
      } else {
        String string;
        if(data["email"]!=null)
        {
          string=data["email"][0];
        }else if(data["phone"]!=null)
        {
          string=data["phone"][0];
        }else if(data["password"]!=null)
        {
          string=data["password"][0];
        }
        print(string);
        emit(RegisterErrorState(string));

      }
    });

    return response;
  }
    /*Future<http.Response> registerAndLogin(filePath, context, fname, lname,
        email, phone, password,type) async
    {
      http.Response response;
      uploadFile(
          filePath,
          context,
          fname,
          lname,
          email,
          phone,
          password,type).then((value) async {
        if (value.statusCode == 200) {
          var APIURL = Uri.parse('https://wanderguide.net/api/auth/login');
          Map mapData = {
            'email': email,
            'password': password,
            'type':type
          };
          http.Response response = await http.post(APIURL, body: mapData);
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            print(data);
            var token = data['remember_token'];
            print(token);
            CacheHelper.saveData(key: 'remember_token', value: token);
            bool isOrganizer;
            type=="user"?isOrganizer=false:true;
            CacheHelper.saveData(key: 'isOrganizer', value: isOrganizer);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  HomeLayout()),(context)=>false);
          }
        }
      });
      return response;
    }*/

    void getImage()
    {
      emit(RegisterGetImageState());
    }

    void changeRadioButton()
    {

      emit(ChangeRadioButtonState());
    }
  Future loginUser(context,email,pass,type,isOrganizer) async {
    emit(LoginLoadingState());
    var APIURL = Uri.parse('https://wanderguide.net/api/auth/login');
    Map mapData = {
      'email': email,
      'password': pass,
      "type":type
    };
    http.Response response = await http.post(APIURL, body: mapData);

    if (response.statusCode == 200) {
      emit(LoginSuccessState());
      var data = jsonDecode(response.body);
      print(data);
      var token = data['remember_token'];
      print(token);
      CacheHelper.saveData(key: 'remember_token', value: token);
      CacheHelper.saveData(key: 'isOrganizer', value: isOrganizer);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) =>
       HomeLayout()), (context) => false);
    } else {
      emit(LoginErrorState("Please Check Email or Password"));
    }
  }
  bool valueSwitch = false;
  changeSwitchValue(value)
  {
    valueSwitch=value;
    emit(ChangeSwitchValueState());
  }

  Future forgetPass(email,context) async {
    emit(ForgetPassLoadingState());
    var APIURL = Uri.parse('https://wanderguide.net/api/forgetpassword');
    Map mapData = {
      'email': email,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    if (jsonDecode(response.body)["status"]) {
      emit(ForgetPassSuccessState());
      var data = jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ResetPassWord(email,data["msg"],data["data"]["client"]["remember_token"])));
      print(data);
    }else{
      var data = jsonDecode(response.body);
      print(data);
      emit(ForgetPassErrorState(data["msg"].toString()));
    }
  }
  Future resetPass(email,context,msg,pass,token) async {
    emit(ResetPassLoadingState());
    var APIURL = Uri.parse('https://wanderguide.net/api/resetpassword');
    Map mapData = {
      'email': email,
       "code":msg,
       'new_password':pass
    };
    http.Response response = await http.post(APIURL, body: mapData);
    if (jsonDecode(response.body)["msg"].toString().contains("Password updated successfully")) {
      emit(ResetPassSuccessState());
      var data = jsonDecode(response.body);
      CacheHelper.saveData(key: "remember_token", value: token);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=>HomeLayout()),(context)=>false);
      print(data);
    }else{
      var data = jsonDecode(response.body);
      print(data);
      emit(ResetPassErrorState(data["msg"].toString()));
    }
  }
  void changeLang(context,int index){
    Locale locale;
    switch(index){
      case 1:
        locale =  const Locale("en","US");
        break;
      case 2:
        locale =  const Locale("ar","EG");
        break;
    }
    MyApp.setLocale(context, locale);
    emit(LangChangeState());
  }

  void changeScreensLogIn(index)
  {
    changeScreensLogInIndex=index;
    emit(ChangeScreensLogInState());
  }
}