import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/home_layout.dart';
import 'package:wander_guide/modules/login/cubit/cubit.dart';
import 'package:wander_guide/modules/login/cubit/states.dart';
import 'package:wander_guide/modules/login/lang_list.dart';
import 'package:wander_guide/modules/login/register.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

import 'forget_pass_screen.dart';

class SignInScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKeySingIn = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldFormKeySingIn = GlobalKey<ScaffoldState>();
  TextEditingController emailControllerSingIn = TextEditingController();
  TextEditingController passControllerSingIn = TextEditingController();
  File _file;
  String type;
  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      _file = File(result.files.single.path.toString());
    } else {
    }

  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context,state) {
          if (state is LoginErrorState) {
            scaffoldFormKeySingIn.currentState.showSnackBar(
                 SnackBar(content: Text( state.error,
                  style: const TextStyle(color: Colors.white),),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.blue,));
          }
          if (state is RegisterErrorState) {
            scaffoldFormKeySingIn.currentState.showSnackBar(
                SnackBar(content: Text( state.error,
                  style: const TextStyle(color: Colors.white),),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.blue,));
          }
        },
        builder: (context,state){
          return Scaffold(
            key: scaffoldFormKeySingIn,

            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20,top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton(
                          underline: const SizedBox(),
                          icon: const Icon(Icons.language,color: Colors.black,),
                          items: Language.languageList().map<DropdownMenuItem<Language>>
                            ((lang) => DropdownMenuItem<Language>(
                            value: lang,
                            child: Row(
                              children: [
                                Text(lang.flag),
                                const SizedBox(width: 8,),
                                Text(lang.name,style: const TextStyle(fontSize: 14),)
                              ],
                            ),
                          )
                          ).toList(),
                          onChanged: (Language value){
                            RegisterCubit.get(context).changeLang(context, value.id);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ToggleSwitch(
                      animate: true,
                      animationDuration: 400,
                      minWidth: 180.0,
                      minHeight: 40.0,
                      fontSize: 16.0,
                      initialLabelIndex: RegisterCubit.get(context).changeScreensLogInIndex,
                      activeBgColor: const [Colors.deepOrange],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey[300],
                      inactiveFgColor: Colors.grey[900],
                      cornerRadius: 20,
                      radiusStyle: true,
                      totalSwitches: 2,
                      labels: [getLang(context, "Sign In"), getLang(context, "Sign Up")],
                      onToggle: (index) {
                        RegisterCubit.get(context).changeScreensLogIn(index);
                        print('switched to: $index');
                      },
                    ),
                  ),
                  RegisterCubit.get(context).changeScreensLogInIndex==0?
                  Column(
                    children: [
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(getLang(context, "Do You Have Account"), style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        child: Form(
                          key: _formKeySingIn,
                          child: Column(
                            children: [
                              const SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 30),
                                child: TextFormField(
                                  controller: emailControllerSingIn,
                                  cursorColor: const Color(0xFFFE6B02),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric
                                      (vertical: 5,horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: getLang(context, "Email"),
                                    labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return getLang(context, "*Required");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 30),
                                child: TextFormField(
                                  controller: passControllerSingIn,
                                  cursorColor: const Color(0xFFFE6B02),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric
                                      (vertical: 5,horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: getLang(context, "Password"),
                                    labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return getLang(context, "*Required");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Text(getLang(context, "Type Of Account"),
                                style: const TextStyle(color: Colors.black,fontSize: 14),),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: RadioListTile<SingingCharacterUserLogin>(
                                      title: Text(getLang(context, "User"),style: const TextStyle(
                                          color: Colors.black,fontSize: 16),),
                                      value: SingingCharacterUserLogin.user,
                                      groupValue: _characterUser,
                                      onChanged: (SingingCharacterUserLogin value) {
                                        RegisterCubit.get(context).changeRadioButton();
                                        _characterUser = value;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: RadioListTile<SingingCharacterUserLogin>(
                                      title:  Text(getLang(context, "Organizer"),style:
                                      const TextStyle(color: Colors.black,fontSize: 16),),
                                      value: SingingCharacterUserLogin.organizer,
                                      groupValue: _characterUser,
                                      onChanged: (SingingCharacterUserLogin value) {
                                        RegisterCubit.get(context).changeRadioButton();
                                        _characterUser = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child:  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPasswordScreen()));
                                    },
                                    child: Text(
                                      getLang(context, "Forget Password"),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent,

                                        decoration: TextDecoration.underline
                                      ),
                                    )),
                              ),
                              state is LoginLoadingState?const
                              Center(child: CircularProgressIndicator()):
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .3,
                                padding: const EdgeInsets.all(0.0),
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.grey[700],
                                  onPressed: () {
                                    if (_formKeySingIn.currentState.validate()) {
                                      RegisterCubit.get(context).loginUser(
                                        context,emailControllerSingIn.text,passControllerSingIn.text,
                                          _characterUser==SingingCharacterUserLogin.user?
                                              "user":"organizer",
                                          _characterUser==SingingCharacterUserLogin.user?false:true
                                      );
                                    }
                                  },
                                  shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    getLang(context, "Sign In"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getLang(context, "You Don't Have Account, Sign Up"),
                                    style: const TextStyle(color:
                                    Colors.black, fontSize: 14),),
                                  const SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      _showMyDialog(context);
                                    },
                                    child: Text(getLang(context, "Sign Up"),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline
                                    ),),
                                  )
                                ],
                              ),
                              const SizedBox(height: 40,),*/
                             /* Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .4,
                                  margin: EdgeInsets.only(
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .01,
                                  ),
                                  child: OutlinedButton(
                                      child: Text(getLang(context, "Sign Up"),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )),
                                      style: OutlinedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(color: Colors.blue),
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      onPressed: () {
                                        _showMyDialog(context);
                                      }
                                  )),*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ):
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only( right: 20, left: 20),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        getFile().then((value) {
                                          RegisterCubit.get(context).getImage();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Stack(
                                            alignment: AlignmentDirectional.bottomEnd,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage:_file==null?
                                                const AssetImage("assets/user.png"):FileImage(_file),
                                                backgroundColor: Colors.grey,
                                              ),
                                              const Icon(Icons.camera_alt)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                       contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "First Name"),
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: fnameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "Last Name"),
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: lnameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "Email"),
                                        labelStyle:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: emailControllerSingIn,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        labelText: getLang(context, "Phone"),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelStyle:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: phoneController,

                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "Password"),
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: passControllerSingIn,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "confirm Password"),
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: passCheckController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      cursorColor: const Color(0xFFFE6B02),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelText: getLang(context, "Description"),
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      controller: descriptionController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return getLang(context, "*Required");
                                        }
                                        return null;
                                      },
                                    ),
                                    Text(getLang(context, "Type Of Account"),
                                      style: const TextStyle(color: Colors.black,fontSize: 14),),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile<SingingCharacterUserRegister>(
                                            title: Text(getLang(context, "User"),style: const TextStyle(
                                                color: Colors.black,fontSize: 16),),
                                            value: SingingCharacterUserRegister.user,
                                            groupValue: _characterUserRegister,
                                            onChanged: (SingingCharacterUserRegister value) {
                                              RegisterCubit.get(context).changeRadioButton();
                                              _characterUserRegister = value;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile<SingingCharacterUserRegister>(
                                            title:  Text(getLang(context, "Organizer"),style:
                                            const TextStyle(color: Colors.black,fontSize: 16),),
                                            value: SingingCharacterUserRegister.organizer,
                                            groupValue: _characterUserRegister,
                                            onChanged: (SingingCharacterUserRegister value) {
                                              RegisterCubit.get(context).changeRadioButton();
                                              _characterUserRegister = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(getLang(context, "Agree to the terms and conditions"),style:
                                        const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        const Spacer(),
                                        Switch(value: RegisterCubit.get(context).valueSwitch, onChanged: (value){
                                          RegisterCubit.get(context).changeSwitchValue(value);
                                        }),
                                      ],
                                    ),
                                    state is RegisterLoadingState ? const Center(child: CircularProgressIndicator()):
                                    Container(
                                        width: MediaQuery.of(context).size.width * .4,
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height * .03,
                                        ),
                                        child: OutlinedButton(
                                            child:  Text(getLang(context, "Create"),
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            style: OutlinedButton.styleFrom(
                                              primary: Colors.white,
                                              side: const BorderSide(color: Colors.blue),
                                              backgroundColor: Colors.white,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))),
                                            ),
                                            onPressed: () {
                                              if (RegisterCubit
                                                  .get(context)
                                                  .valueSwitch) {
                                                if (passControllerSingIn.text ==
                                                    passCheckController.text) {
                                                  if (_formKey.currentState
                                                      .validate() &&
                                                      _file != null) {
                                                    RegisterCubit.get(context)
                                                        .uploadFile(
                                                        _file,
                                                        context,
                                                        fnameController.text,
                                                        lnameController.text,
                                                        emailControllerSingIn.text,
                                                        phoneController.text,
                                                        passControllerSingIn.text,
                                                        descriptionController.text,
                                                        _characterUserRegister==SingingCharacterUserRegister.user?
                                                    "user":"organizer");
                                                  }
                                                  else {
                                                    scaffoldFormKeySingIn.currentState
                                                        .showSnackBar(const
                                                    SnackBar(content: Text(
                                                      "Please Choose Image",
                                                      style:
                                                      TextStyle(color: Colors
                                                          .white),),
                                                      backgroundColor: Colors
                                                          .blue,));
                                                  }
                                                } else {
                                                  scaffoldFormKeySingIn.currentState
                                                      .showSnackBar(const
                                                  SnackBar(content: Text(
                                                    "Please Check Confirm Password",
                                                    style:
                                                    TextStyle(color: Colors
                                                        .white),),
                                                    backgroundColor: Colors
                                                        .blue,));
                                                }
                                              }else{
                                                scaffoldFormKeySingIn.currentState
                                                    .showSnackBar(
                                                    SnackBar(content: Text(
                                                      getLang(context, "Agree to the terms and conditions"),
                                                      style:
                                                      const TextStyle(color: Colors
                                                          .white),),
                                                      backgroundColor: Colors
                                                          .blue,));
                                              }
                                            }
                                        )),
                                    const SizedBox(height: 60,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 /* Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context)=>RegisterCubit(),
          child: BlocConsumer<RegisterCubit,RegisterStates>(
            listener: (context,state){},
            builder:(context,state){
              return Scaffold(appBar: AppBar(
                leading: IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios), onPressed: () {
                  Navigator.of(context).pop();
                },),
                centerTitle: true,
                title:  Text(getLang(context, "Sign Up"), style:
                const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),),
              ),
                  body: Center(
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * .9,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .9,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          color: HexColor("#0f1442")
                      ),
                      child: Column(
                          children: [
                             Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 60, bottom: 10),
                              child: Center(
                                  child: Text(getLang(context, "Register as"), style: const TextStyle(
                                      color: Colors.white, fontSize: 23,
                                      fontWeight: FontWeight.bold),)),
                            ),
                            Column(
                              children: <Widget>[
                                RadioListTile<SingingCharacter>(
                                  title: Text(getLang(context, "User"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,fontSize: 20),),
                                  value: SingingCharacter.user,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    RegisterCubit.get(context).changeRadioButton();
                                    _character = value;
                                  },
                                ),
                                RadioListTile<SingingCharacter>(
                                  title:  Text(getLang(context, "Organizer"),style: const TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,fontSize: 20),),
                                  value: SingingCharacter.organizer,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    RegisterCubit.get(context).changeRadioButton();
                                    _character = value;
                                  },
                                ),
                                MaterialButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      SignUpScreen(type:_character==SingingCharacter.user?"user":"organizer")));
                                },
                                  color: Colors.white,
                                  child: Text(getLang(context, "Submit"),
                                    style: TextStyle(color: HexColor("#0f1442")),),
                                )
                              ],
                            ),
                          ]
                      ),
                    )
                    ,)
              );
            }
          ),
        );
      },
    );
  }*/
}
enum SingingCharacter { user, organizer }
SingingCharacter _character = SingingCharacter.user;

enum SingingCharacterUserLogin { user, organizer }
SingingCharacterUserLogin _characterUser = SingingCharacterUserLogin.user;

enum SingingCharacterUserRegister { user, organizer }
SingingCharacterUserRegister _characterUserRegister = SingingCharacterUserRegister.user;

