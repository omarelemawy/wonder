import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_layout.dart';

class EditProfile extends StatelessWidget {
  var img;
  var email;
  var fname;
  var lname;
  var phone;
  File _file;
  TextEditingController emailController =TextEditingController();

  TextEditingController fnameController =TextEditingController();
  TextEditingController lnameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  EditProfile(this.img,this.email,this.fname,this.lname,this.phone);
  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    fnameController.text = fname;
    lnameController.text=lname;
    phoneController.text=phone;
    return BlocProvider(
        create: (context)=>HomeCubit(),
        child: BlocConsumer<HomeCubit,HomeStates>(
          listener:(context,state){} ,
          builder: (context,state){
            var cubit = HomeCubit.get(context);
            return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: () {
                   Navigator.of(context).pop();
                },),
              centerTitle: true,
              title: Text(getLang(context, "Edit Profile"),
                style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              color:Colors.blueAccent ,
              child: ListView(
                children: [
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: (){
                        getFile().then((value) {
                          HomeCubit.get(context).getImage();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:_file==null?NetworkImage(img):FileImage(_file),
                                backgroundColor: Colors.grey,
                              ),
                              Icon(Icons.camera_alt)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: getLang(context, "Email"),
                              labelStyle: TextStyle(color: Colors.grey[300])
                          ),
                           controller: emailController,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: getLang(context, "First Name"),
                              labelStyle: TextStyle(color: Colors.grey[300])
                          ),
                          style: TextStyle(color: Colors.white),
                          controller: fnameController,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: getLang(context, "Last Name"),
                              labelStyle: TextStyle(color: Colors.grey[300])
                          ),
                          style: TextStyle(color: Colors.white),
                          controller: lnameController,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: getLang(context, "Phone"),
                              labelStyle: TextStyle(color: Colors.grey[300])
                          ),
                          style: TextStyle(color: Colors.white),
                          controller: phoneController,
                        ),
                        const SizedBox(height: 70,),
                        state is GetLoadingEditProfileHomeStates?
                        Center(child: const CircularProgressIndicator()) : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.deepOrange,width: 2)
                          ),
                          child: MaterialButton(
                            onPressed: (){
                                   cubit.editProfile(fnameController.text,
                                       lnameController.text,
                                     emailController.text,phoneController.text,_file)
                                       .then((value) {
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                                             (context)=> HomeLayout()),
                                               (route) => false);
                                   });
                                 },child:  Text(getLang(context, "Submit"),style:
                          const TextStyle(color: Colors.deepOrange,
                              fontSize: 18),),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) ,
             );
          },
        ),
    );
  }
  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _file = File(result.files.single.path.toString());
    } else {}
  }
}
