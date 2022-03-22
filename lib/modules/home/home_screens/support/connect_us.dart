import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';

class ConnectUs extends StatelessWidget {
   ConnectUs({Key key}) : super(key: key);
  TextEditingController emailController= TextEditingController();
  TextEditingController massageBodyController= TextEditingController();
  TextEditingController massageController= TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: _globalKey,
            appBar: AppBar(
              leading: IconButton(
                icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              elevation: 00,
              title: Text(getLang(context, "Connect with us"),
                style: TextStyle(color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.only(right: 20.0,left: 20,top: 30),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       SizedBox(height: 30,),
                       Text(getLang(context, "contact form"),style:
                       TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                          SizedBox(height: 30,),
                          TextFormField(
                            controller: emailController,
                         decoration:  InputDecoration(
                             labelText: getLang(context, "Email"),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(20))
                             )
                         ),
                       ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: massageBodyController,
                         decoration:  InputDecoration(
                             labelText: getLang(context, "Message Body"),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(20))
                             )
                         ),
                       ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: massageController,
                         decoration:  InputDecoration(
                             labelText: getLang(context, "Message"),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(20))
                             )
                         ),
                       ),
                          SizedBox(height: 40,),
                      state is SendMailLoadingStates? const Center(child: CircularProgressIndicator()):
                      Container(
                         decoration: BoxDecoration(
                             color: Colors.deepOrangeAccent,
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         width: double.infinity,
                         child: MaterialButton(
                           onPressed: (){
                             HomeCubit.get(context).
                             sendMail(emailController.text, massageBodyController.text, massageController.text).then((value) {
                               _globalKey.currentState.showSnackBar(
                                   SnackBar(
                                     backgroundColor: Colors.blue,
                                       content: Text(getLang(context, "Message sent success"),style: TextStyle(color: Colors.white),)));
                             });
                           },
                           child: Text(getLang(context, "Send"),style:
                           TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                         ),
                       ),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.location_on,color:Colors.deepOrangeAccent,),
                           SizedBox(width: 5,),
                           Text(getLang(context, "Place"),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                         ],
                       ),
                       Text("Al Khobar, Saudi Arabia",style: TextStyle(color: Colors.grey[800],fontSize: 14,)),
                       SizedBox(height: 10,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.phone,color:Colors.deepOrangeAccent,),
                           SizedBox(width: 5,),
                           Text(getLang(context, "Phone"),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                         ],
                       ),
                       Text("00966544649428",style: TextStyle(color: Colors.grey[800],fontSize: 14,)),
                       SizedBox(height: 10,),
                       Row( mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.mail_outline,color:Colors.deepOrangeAccent,),
                           SizedBox(width: 5,),
                           Text(getLang(context, "Email"),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                         ],
                       ),
                       Text("FALATMAH@GMAIL.COM",style: TextStyle(color: Colors.grey[800],fontSize: 14,)),
                     ],
                   ),
                 ),
            ),
          );
        },
      ),
    );
  }
}
