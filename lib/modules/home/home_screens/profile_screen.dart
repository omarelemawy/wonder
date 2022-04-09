import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_screens/about_us.dart';
import 'package:wander_guide/modules/home/home_screens/edit_profile.dart';
import 'package:wander_guide/modules/home/home_screens/organizers_screen.dart';
import 'package:wander_guide/modules/home/home_screens/support/connect_us.dart';
import 'package:wander_guide/modules/home/home_screens/support/privacy_policy.dart';
import 'package:wander_guide/modules/home/home_screens/support/terms_and_conditions.dart';
import 'package:wander_guide/modules/login/lang_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context)=>HomeCubit()..getProfile(),
            child: BlocConsumer<HomeCubit,HomeStates>(
             listener: (context,state){},
             builder: (context,state){
               var cubit = HomeCubit.get(context);
               return
                 Scaffold(
                   appBar: AppBar(
                     centerTitle: true,
                     elevation: 00,
                     title: Text(getLang(context, "Profile"),
                       style: const TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
                     ),
                   ),
                   body:
                   state is GetLoadingProfileDataHomeStates? const
                   Center(child: CircularProgressIndicator()):
                   Container(
                     color:Colors.white ,
                     child: state is GetErrorProfileDataHomeStates?
                     SizedBox(
                       width: double.infinity,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(getLang(context, "Log In Again Please"),style: TextStyle(fontSize: 20),),
                           SizedBox(height: 20,),
                          state is LogOutLoadingStates?
                          const Center(child:  CircularProgressIndicator()):
                          MaterialButton(
                             onPressed: () {
                             cubit.logoutUser(context);
                           },
                             child:  Text(getLang(context, "Go"),
                               style: const TextStyle(color: Colors.white),),
                             color: Colors.deepOrange,)

                         ],
                       ),
                     ):
                     Container(
                       child: cubit.profileList.isNotEmpty?
                       ListView(
                         children: [
                           Container(
                             padding: const EdgeInsets.all( 15),
                             child: Row(
                               children: [
                                 Container(
                                   clipBehavior: Clip.antiAliasWithSaveLayer,
                                   child: ProgressiveImage(
                                     imageError:  "assets/profile.jpg",
                                     width: 100.0,
                                     image: cubit.profileList[0].img,
                                     height: 100.0,
                                     fit: BoxFit.fill,

                                   ),
                                   decoration:  BoxDecoration(
                                       shape: BoxShape.circle,
                                       boxShadow: [ BoxShadow(
                                         color: Colors.grey.withOpacity(0.5),
                                         spreadRadius: 5,
                                         blurRadius: 7,
                                         offset: Offset(0, 3), // changes position of shadow
                                       ),
                                         BoxShadow(
                                           color: Colors.grey.withOpacity(0.5),
                                           spreadRadius: 5,
                                           blurRadius: 7,
                                           offset: Offset(0, 3), // changes position of shadow
                                         ),]
                                   ),
                                 ),
                                 const SizedBox(width: 20,),
                                 Column(
                                   children: [
                                     Text(
                                       cubit.profileList[0].fname+" "+cubit.profileList[0].lname,
                                       style: const TextStyle(
                                           color: Colors.black,
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold
                                       ),
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 1,
                                     ),
                                     const SizedBox(height: 5,),
                                     Text(
                                       cubit.profileList[0].email,
                                       style: const TextStyle(
                                         color: Colors.black,
                                         fontSize: 13,
                                       ),
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 1,
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10.0),
                             child: Container(
                               height: 40,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color:Colors.grey[300],
                               ),
                               child: Row(
                                 children: [
                                   SizedBox(width: 10,),
                                   Icon(Icons.settings,color: Colors.deepOrange[400],),
                                   SizedBox(width: 10,),
                                   Text(getLang(context, "Settings"),style:
                                   const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                   EditProfile(cubit.profileList[0].img,
                                       cubit.profileList[0].email,
                                       cubit.profileList[0].fname,cubit.profileList[0].lname,
                                       cubit.profileList[0].phone)));
                             },
                             child: Container(
                               height: 35,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Expanded(
                                     child: Row(
                                       children: [
                                         Text(getLang(context, "Edit Profile"),style: const TextStyle(color: Colors.black,
                                           fontSize: 12,),),
                                         const Spacer(),
                                         const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(
                                   builder: (context)=>const OrganizersScreen()));
                             },
                             child: Container(
                               height: 35,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Expanded(
                                     child: Row(
                                       children: [
                                         Text(getLang(context, "organizers"),style: const TextStyle(color: Colors.black,fontSize: 14,),),
                                         const Spacer(),
                                         const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Container(
                               height: 40,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color:Colors.grey[300],
                               ),

                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   SizedBox(width: 10,),
                                   Icon(Icons.support_agent,color: Colors.deepOrange[400],),
                                   SizedBox(width: 10,),
                                   Text(getLang(context, "the support"),style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>const AboutUs()));
                             },
                             child: Container(
                               height: 35,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Text(getLang(context, "who are we"),style: const TextStyle(color: Colors.black,fontSize: 14,),),
                                   const Spacer(),
                                   const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                               const PrivacyPolicy()));
                             },
                             child: Container(
                               height: 35,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Text(getLang(context, "Privacy Policies"),style: const TextStyle(color: Colors.black,
                                     fontSize: 14,),),
                                   const Spacer(),
                                   const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                   ConnectUs()));
                             },
                             child: Container(
                               height: 35,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Text(getLang(context, "Connect with us"),style: const TextStyle(color: Colors.black,fontSize: 14,),),
                                   const Spacer(),
                                   const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                               const TermsAndConditions()));
                             },
                             child: Container(
                               height: 40,
                               padding: const EdgeInsets.only(right: 22,left: 22),
                               width: double.infinity,
                               color:Colors.white,
                               child: Row(
                                 children: [
                                   Text(getLang(context, "Terms and Conditions"),style: const TextStyle(color: Colors.black,fontSize: 14,),),
                                   const Spacer(),
                                   const Icon(Icons.chevron_right_rounded,color: Colors.black,)
                                 ],
                               ),
                             ),
                           ),
                           DropdownButton(
                             underline: const SizedBox(),
                             hint: Padding(
                               padding: const EdgeInsets.only(right: 22.0,left: 22),
                               child: Text(getLang(context, "Language"),style: const TextStyle(color: Colors.black),),
                             ),
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
                               HomeCubit.get(context).changeLang(context, value.id);
                             },
                           ),
                           state is LogOutLoadingStates?const Center(child: CircularProgressIndicator()):
                           Container(
                               margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                               height: 40,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color:Colors.grey[300],
                               ),
                               child: MaterialButton(
                                   child: Text(
                                     getLang(context, "Exit"),
                                     style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                                   ),
                                   onPressed: () {
                                     cubit.logoutUser(context);
                                   })),
                           SizedBox(height: 30,)
                         ],
                       ):
                       const Center(child: CircularProgressIndicator(color: Colors.black,)),
                     )
                   )
               );
             },
            ),
          );
  }
}
