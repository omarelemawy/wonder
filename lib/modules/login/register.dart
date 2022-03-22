import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/login/cubit/cubit.dart';
import 'package:wander_guide/modules/login/cubit/states.dart';
import 'package:wander_guide/modules/login/singin_screen.dart';
import 'package:wander_guide/shared/netWork/remot/dio_helper.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({this.type});
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
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state) {

          if(state is RegisterErrorState)
            {
              keyScaffold.currentState.showSnackBar(SnackBar(content: Text(state.error))) ;
            }
        },
        builder: (context,state){
          return Scaffold(
            key:keyScaffold,
            appBar: AppBar(
              leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context)=>SignInScreen()),(context)=>false);
              },),
              centerTitle:true,
              title:   Text(getLang(context, "Sign Up"),style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 20, left: 20),
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
                                             radius: 50,
                                             backgroundImage:_file==null? AssetImage("assets/user.png"):FileImage(_file),
                                             backgroundColor: Colors.grey,
                                          ),
                                          Icon(Icons.camera_alt)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  cursorColor: Color(0xFFFE6B02),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: getLang(context, "First Name"),
                                    labelStyle: TextStyle(
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
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextFormField(
                                    cursorColor: Color(0xFFFE6B02),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: getLang(context, "Last Name"),
                                      labelStyle: TextStyle(
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
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: TextFormField(
                                    cursorColor: Color(0xFFFE6B02),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: getLang(context, "Email"),
                                      labelStyle:TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return getLang(context, "*Required");
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Color(0xFFFE6B02),
                                    decoration: InputDecoration(
                                      labelText: getLang(context, "Phone"),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle:TextStyle(
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
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: TextFormField(
                                    cursorColor: Color(0xFFFE6B02),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: getLang(context, "Password"),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    controller: passController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return getLang(context, "*Required");
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: TextFormField(
                                    cursorColor: Color(0xFFFE6B02),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: getLang(context, "confirm Password"),
                                      labelStyle: TextStyle(
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
                                ),
                                Row(
                                  children: [
                                    Text(getLang(context, "Agree to the terms and conditions"),style:
                                    const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                    Spacer(),
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
                                        side: BorderSide(color: Colors.blue),
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      onPressed: () {
                                        if (RegisterCubit
                                            .get(context)
                                            .valueSwitch) {
                                          if (passController.text ==
                                              passCheckController.text) {
                                            if (_formKey.currentState
                                                .validate() &&
                                                _file != null) {
                                              /*RegisterCubit.get(context)
                                                  .uploadFile(
                                                  _file,
                                                  context,
                                                  fnameController.text,
                                                  lnameController.text,
                                                  emailController.text,
                                                  phoneController.text,
                                                  passController.text,type);*/
                                            } else {
                                              keyScaffold.currentState
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
                                            keyScaffold.currentState
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
                                          keyScaffold.currentState
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
                                SizedBox(height: 60,)
                              ],
                            ),
                          ),
                        ),
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
}

