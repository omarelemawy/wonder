import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/login/cubit/cubit.dart';
import 'package:wander_guide/modules/login/cubit/states.dart';

class ForgetPasswordScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  String token;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state) {
          if (state is ForgetPassErrorState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blue,
                    content:Text(state.error,style:
                    const TextStyle(color: Colors.white),)));
          }
        },
        builder: (context,state){
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle:true,
              title:   Text(getLang(context, "Forgot your password"),style: TextStyle(color: Colors.white),),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 60, right: 20, left: 20),
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  elevation: 4,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .40,
                    padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            getLang(context, "Send a confirmation message"),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              onSaved: (value) {
                                _email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return  getLang(context, "*required");
                                }
                                return null;
                              },
                              cursorColor: Color(0xFFFE6B02),
                              decoration:  InputDecoration(
                                  labelText: getLang(context, "Email"),
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                              ),
                            ),
                          ),
                          state is ForgetPassLoadingState ? Container(
                            margin: const EdgeInsets.only(top: 40.0),
                            child: const
                            CircularProgressIndicator(),
                          ):
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width * .45,
                            margin: const EdgeInsets.only(top: 40.0),
                            height: 40,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: RaisedButton(
                              color: Color(0xFFFE4B02),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  RegisterCubit.get(context).forgetPass(emailController.text,context);
                                }
                              },
                              child: Text(
                                getLang(context, "Submit"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,),
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