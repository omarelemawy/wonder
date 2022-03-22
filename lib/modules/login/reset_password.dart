import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wander_guide/componants/app_locale.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ResetPassWord extends StatelessWidget {

    String email,msg,token;
    ResetPassWord(this.email,this.msg,this.token, {Key key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  TextEditingController numController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state) {
          if (state is ResetPassErrorState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                    backgroundColor: Colors.blue,
                    content: Text(state.error, style:
                    const TextStyle(color: Colors.white),)));
          }
        },
        builder: (context,state){
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: IconButton(icon:
              const Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: () { Navigator.of(context).pop(); }
                ,),
              centerTitle:true,
              title:   Text(getLang(context, "Set a new password"),style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  elevation: 4,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .60,
                    padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            getLang(context, "Set password"),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 40,),
                          Text(getLang(context, "Verification code"),style: TextStyle(color: Colors.black,fontSize: 15),),
                          SizedBox(height: 10,),
                          Container(
                            child:  PinCodeTextField(
                              autofocus: true,
                              controller: numController,
                              hideCharacter: true,
                              highlight: true,
                              highlightColor: Colors.blue,
                              defaultBorderColor: Colors.black,
                              hasTextBorderColor: Colors.green,
                              highlightPinBoxColor: Colors.orange,
                              maskCharacter: "😎",
                              pinBoxWidth: 50,
                              pinBoxHeight: 64,
                              hasUnderline: true,
                              wrapAlignment: WrapAlignment.spaceAround,
                              pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                              pinTextStyle: TextStyle(fontSize: 22.0),
                              pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                              pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
//                    highlightAnimation: true,
                              highlightAnimationBeginColor: Colors.black,
                              highlightAnimationEndColor: Colors.white12,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            child: TextFormField(
                              controller: passController,
                              onSaved: (value) {
                                _email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return getLang(context, "*Required");
                                }
                                return null;
                              },
                              cursorColor: const Color(0xFFFE6B02),
                              decoration:  InputDecoration(
                                  labelText: getLang(context, "New password"),
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20)))
                              ),
                            ),
                          ),
                          state is ResetPassLoadingState ? Container(
                            margin: const EdgeInsets.only(top: 50.0),
                            child: const
                            CircularProgressIndicator(),
                          ):
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width * .45,
                            margin: const EdgeInsets.only(top: 60.0),
                            height: 40,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: RaisedButton(
                              color: Color(0xFFFE4B02),
                              onPressed: () {
                                if (_formKey.currentState.validate())
                                {
                                   if(passController.text.length >= 6){
                                     if(msg == numController.text){
                                        RegisterCubit.get(context).resetPass(email,context,msg,passController.text,token);
                                     }else{
                                       _scaffoldKey.currentState.showSnackBar(const SnackBar(
                                         backgroundColor: Colors.blue,
                                           content: Text("The number is incorrect",
                                             style: TextStyle(color: Colors.white),)));
                                     }
                                   }else{
                                     _scaffoldKey.currentState.showSnackBar(const SnackBar(
                                         backgroundColor: Colors.blue,
                                         content: Text("The password must be at least 6 characters",
                                           style: TextStyle(color: Colors.white),)));
                                   }
                                }
                              },
                              child: Text(
                                getLang(context, "Submit"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
