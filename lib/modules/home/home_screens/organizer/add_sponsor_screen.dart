import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/bloc/state_organizer.dart';

import 'bloc/cubit_organizer.dart';

class AddSponsorScreen extends StatelessWidget {
   AddSponsorScreen({Key key}) : super(key: key);
  TextEditingController getName = TextEditingController();
  TextEditingController getEmail = TextEditingController();
  TextEditingController getPhone = TextEditingController();
   File _fileFirstDesign;
   Future getFile() async {
     FilePickerResult result = await FilePicker.platform.pickFiles();
     if(result != null) {
       _fileFirstDesign = File(result.files.single.path.toString());
     } else
     {
     }
   }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>OrganizerCubit(),
      child: BlocConsumer<OrganizerCubit,OrganizerStates>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("أضافة ممول",style: TextStyle(color: Colors.white),),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14),
                        controller: getName,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius:BorderRadius.circular(10)),
                           label:Text( "الأسم بالكامل"),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 14),
                        controller: getEmail,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius:BorderRadius.circular(10)),
                          label:Text( "البريد الالكتروني"),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14),
                        controller: getPhone,
                        decoration:InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius:BorderRadius.circular(10)),
                          label:Text( "رقم الهاتف"),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 15,),

                    GestureDetector(
                      onTap: (){
                        getFile().then((value) {
                          OrganizerCubit.get(context).getImageFirstDesign();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)
                        ),
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: _fileFirstDesign==null?Row(
                          children: [
                            const SizedBox(width: 10,),
                            const Icon(Icons.cloud_upload,color: Colors.deepOrange,
                              size: 40,
                            ),
                            const SizedBox(width: 10,),
                            const Text("أضافة شعار",style:
                            TextStyle(color: Colors.deepOrange,fontSize: 12),)
                          ],
                        ):
                        Image.file(_fileFirstDesign,fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 30,),
                    state is  AddSponsorLoadingStates?
                    CircularProgressIndicator():
                    MaterialButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        OrganizerCubit.get(context).addSponserCubit(
                         context,_fileFirstDesign,getName.text,getEmail.text,getPhone.text
                        );
                      },
                      child: const Text("أضافة", style: const TextStyle(
                          color: Colors.white),),
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){},
      )
    );
  }
}
