import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'bloc/cubit_organizer.dart';
import 'bloc/state_organizer.dart';


class EditEventSponsor extends StatefulWidget {
  const EditEventSponsor({Key key}) : super(key: key);

  @override
  _EditEventSponserState createState() => _EditEventSponserState();
}

class _EditEventSponserState extends State<EditEventSponsor> {
  TextEditingController getTitleAr = TextEditingController();
  TextEditingController getTitleEn = TextEditingController();
  TextEditingController getDetailsAr = TextEditingController();
  TextEditingController getDetailsEn = TextEditingController();
  TextEditingController getPrice = TextEditingController();
  TextEditingController getDate = TextEditingController();
  List<TextEditingController> _controllersThirdDesign = new List();
  File _fileFirstDesign;
  var keyScaffold = GlobalKey<ScaffoldState>();
  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _fileFirstDesign = File(result.files.single.path.toString());
    } else {}
  }

  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrganizerCubit(),
        child: BlocConsumer<OrganizerCubit, OrganizerStates>(
          builder: (context, state) {
            return Scaffold(
              key: keyScaffold,
              appBar: AppBar(
                centerTitle: true,
                title:  Text(
                  getLang(context, "Create Event"), style: const TextStyle(color: Colors.white),),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontSize: 14),
                          controller: getTitleAr,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            label:  Text(getLang(context, "Title In Arabic")),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontSize: 14),
                          controller: getTitleEn,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            label:  Text(getLang(context, "Title In English")),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButton(
                          hint:  Text(getLang(context, "choose category"
                          )), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            _selectedLocation = newValue;
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 14),
                          controller: getDetailsAr,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            label:  Text(getLang(context, "Details In Arabic")),
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
                          controller: getDetailsEn,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            label:  Text(getLang(context, "Details In English")),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 15,),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 14),
                          controller: getPrice,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            label:  Text(getLang(context, "Price")),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () {
                              if (OrganizerCubit
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length < 4) {
                                OrganizerCubit.get(context).addItemLoc(
                                    getLocationDesign(TextEditingController(),context));
                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    SnackBar(content:
                                    Text(getLang(context, "4 only max"))));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add, color:
                                  Colors.white, size: 15,),
                                  const SizedBox(width: 5,),
                                  Text(getLang(context, "Add Time"),style: const TextStyle(color: Colors.white),),
                                  const SizedBox(width: 5,),
                                ],
                              ),
                              decoration:  BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          const Spacer(),
                          /*GestureDetector(
                            onTap: () {
                              if (OrganizerCubit
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length > 0) {
                                OrganizerCubit.get(context).deleteItemLoc(index);
                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    const SnackBar(content:
                                    Text("تم مسح جميع العناصر")));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.delete_rounded, color:
                                  Colors.white, size: 15,),
                                  Text("مسح وقت",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                              decoration:  BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),*/
                          const SizedBox(width: 20,),
                        ],
                      ),
                      const SizedBox(height: 5,),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          _controllersThirdDesign.add(new TextEditingController());
                          return  getLocationDesign(
                              _controllersThirdDesign[index],context,index:index);
                        },
                        itemCount: OrganizerCubit
                            .get(context)
                            .itemsOfInformFieldLocation
                            .length, separatorBuilder:
                          (BuildContext context, int index) => const SizedBox(height: 10,) ,),
                      const SizedBox(height: 15,),

                      GestureDetector(
                        onTap: () {
                          getFile().then((value) {
                            OrganizerCubit.get(context).getImageFirstDesign();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black)
                          ),
                          width: double.infinity,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: _fileFirstDesign == null ? Row(
                            children: [
                              const SizedBox(width: 10,),
                              const Icon(
                                Icons.cloud_upload, color: Colors.deepOrange,
                                size: 40,
                              ),
                              const SizedBox(width: 10,),
                              Text(getLang(context, "Add Photo"), style:
                              TextStyle(
                                  color: Colors.deepOrange, fontSize: 12),)
                            ],
                          ) :
                          Image.file(_fileFirstDesign, fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(height: 30,),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*state is  CreateTripLoadingStates?
                    CircularProgressIndicator():*/ MaterialButton(
                            color: Colors.deepOrange,
                            onPressed: () {
                              /* AddTripBloc.get(context).createTrip(DataOfTrip(
                              typeOfTrips: data.id,
                              onlyWomen: 1,
                              fromPlace: getName.text,
                              description: getDescriptionFirstDesign.text,
                              toPlace: getToLocationFirstDesign.text,
                              maxDay: getEndDateFirstDesign.text,
                            ),
                                data.id,context,_fileFirstDesign);*/
                            },
                            child:  Text(getLang(context, "Add"), style: const TextStyle(
                                color: Colors.white),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {},
        )
    );
  }
  Widget getLocationDesign(TextEditingController editingController,context,{index})
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onTap: (){
          showDatePicker(context: context,
            initialDate: DateTime.now().add(const Duration(hours: 1)),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 10),
          ).then((value) {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted = formatter.format(value);
            editingController.text=formatted;
          });
        },
        style: const TextStyle(fontSize: 14),
        controller: editingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () {
              OrganizerCubit.get(context).deleteItemLoc(index);
              _controllersThirdDesign.removeAt(index);
              /* if (OrganizerCubit
                  .get(context)
                  .itemsOfInformFieldLocation
                  .length > 0) {

              } else {
                keyScaffold.currentState.showSnackBar(
                    const SnackBar(content:
                    Text("تم مسح جميع العناصر")));
              }*/
            },
          ),
          label:  Text(getLang(context, "Time And Date")),
        ),
        maxLines: 1,
      ),
    );
  }
}
