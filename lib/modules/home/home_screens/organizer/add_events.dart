import 'dart:io';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/categories_model.dart';
import 'package:wander_guide/model/sponser.dart';

import 'bloc/cubit_organizer.dart';
import 'bloc/state_organizer.dart';
import 'get_location_for_event_screen.dart';

class AddEvents extends StatelessWidget {
  AddEvents({Key key}) : super(key: key);
  TextEditingController getTitleAr = TextEditingController();
  TextEditingController getTitleEn = TextEditingController();
  TextEditingController getDetailsAr = TextEditingController();
  TextEditingController getDetailsEn = TextEditingController();
  TextEditingController getPrice = TextEditingController();
  TextEditingController getURLLocation = TextEditingController();
  TextEditingController getDate = TextEditingController();
  List<int> microsecondsSinceEpochStartDate=[];
  List<int> microsecondsSinceEpochEndDate=[];
  final List<TextEditingController> _controllersListOfStartDate = [];
  final List<TextEditingController> _controllersListOfEndDate = [];
  final List<TextEditingController> _controllersListOfMaxCapacity = [];
  final List<TextEditingController> _controllersListOfAvailableSeats = [];
  var valueOfLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GroupController controllerSecondDesign = GroupController();
  File _fileFirstDesign;
  var keyScaffold = GlobalKey<ScaffoldState>();
  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _fileFirstDesign = File(result.files.single.path.toString());
    } else {}
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrganizerCubit()..getCatEvent()..getMySponser()..getAllCountriesEvent(),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
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

                        OrganizerCubit.get(context).AllCategoriesList.isEmpty?
                        const Center(child:  CircularProgressIndicator()):
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: DropdownButton(
                            hint:  Text(getLang(context, "choose category"
                            )), // Not necessary for Option 1
                            value: OrganizerCubit.get(context).indexCategoriesAddEvent,
                            onChanged: (newValue) {
                              OrganizerCubit.get(context).changeCategoriesAddEvent(newValue);
                            },
                            items: OrganizerCubit.get(context).AllCategoriesList.map((location) {
                              return DropdownMenuItem(
                                child:  Text(AppLocale.of(context).myLang(context)=="en"?
                                location.titleEn:
                                location.titleAr),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),

                        OrganizerCubit.get(context).allSponserList.isEmpty?
                        const Center(child:  CircularProgressIndicator()):
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: MaterialButton(onPressed: () {
                            _showMultiSelect(context);
                          },
                           child: Text(getLang(context, "Choose Sponsor"
                           )),
                          )
                          /* DropdownButton(
                            hint:  Text(getLang(context, "Choose Sponsor"
                            )), // Not necessary for Option 1
                            value: OrganizerCubit.get(context).indexSponsorAddEvent,
                            onChanged: (newValue) {
                              OrganizerCubit.get(context).changeSponsorAddEvent(newValue);
                            },
                            items: OrganizerCubit.get(context).allSponserList.map((location) {
                              return DropdownMenuItem(
                                child:  Text(AppLocale.of(context).myLang(context)=="en"?
                                location.name:
                                location.name),
                                value: location,
                              );
                            }).toList(),
                          )*/,
                        ),
                        MultiSelectChipDisplay(
                          textStyle: TextStyle(color: Colors.black),
                          items: OrganizerCubit.get(context).allSponserListSelected.map((e) =>
                              MultiSelectItem(e, e.name)).toList(),
                          onTap: (value) {
                            OrganizerCubit.get(context).removeSponserListSelectedAddEvent(value);
                          },
                        ),

                        OrganizerCubit.get(context).allCountriesList.isEmpty?
                        const Center(child:  CircularProgressIndicator()):
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: DropdownButton(
                            hint:  Text(getLang(context, "Choose Countries"
                            )), // Not necessary for Option 1
                            value: OrganizerCubit.get(context).indexCountriesAddEvent,
                            onChanged: (newValue) {
                              OrganizerCubit.get(context).changeOrganizerCountriesLatLong(newValue);
                            },
                            items: OrganizerCubit.get(context).allCountriesList.map((location) {
                              return DropdownMenuItem(
                                child:  Text(AppLocale.of(context).myLang(context)=="en"?
                                location.name:
                                location.name),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
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

                        Row(
                          children: [
                            const SizedBox(width: 50,),
                            SimpleGroupedChips<int>(
                                controller: controllerSecondDesign,
                                itemTitle: const [
                                  "OnLine",
                                  "OffLine",
                                ],
                                isScrolling: true,
                                selectedColorItem: Colors.deepOrange,
                                selectedTextColor: Colors.white,
                                backgroundColorItem: Colors.deepOrange,
                                values: const [1,2],
                                onItemSelected: (item){
                                  print(item);
                                  OrganizerCubit.get(context).changeOnlineModeAddEvent(item);
                                },
                                chipGroupStyle:  ChipGroupStyle.minimize(
                                  selectedColorItem: Colors.deepOrange,
                                  selectedTextColor: Colors.white,
                                  backgroundColorItem: Colors.grey[400],
                                  itemTitleStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        OrganizerCubit.get(context).indexOnlineModeAddEvent==1?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14),
                            controller: getURLLocation,
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
                              label:  const Text( "URL"),
                            ),
                            maxLines: 1,
                          ),
                        ):
                            GestureDetector(
                              onTap: ()async{
                                 var valueOfLocation1 =await Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    const LocationForEventScreen())).then((value)async{
                                   valueOfLocation=value;
                                   List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude,
                                    value.longitude);
                                   print(placemarks[0].country);
                                   OrganizerCubit.get(context).changeLocationLatLong(placemarks[0].country+" "+
                                       placemarks[0].street);

                                });

                                print(valueOfLocation.toString()+"00000000");
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 30,),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children:  [
                                            const SizedBox(width: 5,),
                                             const Icon(Icons.location_pin,color: Colors.white),
                                            const SizedBox(width: 15,),
                                            Text(getLang(context, "Select the place"),style: const TextStyle(color: Colors.white),),
                                            const SizedBox(width: 10,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,)
                                  ,Row(
                                    children: [
                                      const SizedBox(width: 30,),
                                      const Text("The Place you have selected is :",),

                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(OrganizerCubit.get(context).dataOfLocationAddEvent,),
                                ],
                              ),
                            ),

                        const SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return getLang(context, "*Required");
                              }
                              return null;
                            },
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
                                  OrganizerCubit.get(context).addItemAddEvent(
                                      getLocationDesign(
                                          TextEditingController(),
                                          TextEditingController(),
                                          TextEditingController(),
                                          TextEditingController()
                                          ,context));
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
                            _controllersListOfStartDate.add(TextEditingController());
                            _controllersListOfEndDate.add(TextEditingController());
                            _controllersListOfMaxCapacity.add(TextEditingController());
                            _controllersListOfAvailableSeats.add(TextEditingController());
                            return  getLocationDesign(
                                _controllersListOfStartDate[index],
                                _controllersListOfEndDate[index],
                                _controllersListOfMaxCapacity[index]    ,
                                _controllersListOfAvailableSeats[index],
                                context,index:index);
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
                                const TextStyle(
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
                            state is  AddEventLoadingStates?
                      const CircularProgressIndicator(): MaterialButton(
                              color: Colors.deepOrange,
                              onPressed: () {
                                print(valueOfLocation);
                                if(
                                 OrganizerCubit.get(context).indexCountriesAddEvent!=null&&
                                 OrganizerCubit.get(context).indexCategoriesAddEvent!=null&&
                                 OrganizerCubit.get(context).allSponserListSelected.isNotEmpty
                                ) {
                                  if (_formKey.currentState
                                      .validate()) {
                                    if (_fileFirstDesign != null) {
                                      if(valueOfLocation!=null|| OrganizerCubit
                                          .get(context)
                                          .indexOnlineModeAddEvent == 1) {
                                        if (OrganizerCubit
                                            .get(context)
                                            .itemsOfInformFieldLocation
                                            .isNotEmpty) {
                                          OrganizerCubit.get(context)
                                              .addEventCubit(
                                              context,
                                              _fileFirstDesign,
                                              getTitleEn.text,
                                              getTitleAr.text,
                                              getDetailsAr.text,
                                              getDetailsEn.text,
                                              getPrice.text,
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexOnlineModeAddEvent == 2
                                                  ? "offline"
                                                  :
                                              "online",
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexOnlineModeAddEvent == 1
                                                  ? "0"
                                                  : valueOfLocation.longitude.toString(),
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexOnlineModeAddEvent == 1
                                                  ? "0"
                                                  : valueOfLocation.latitude.toString(),
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexOnlineModeAddEvent == 1
                                                  ? getURLLocation.text
                                                  : "",
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexCountriesAddEvent
                                                  .id,
                                              OrganizerCubit
                                                  .get(context)
                                                  .indexCategoriesAddEvent
                                                  .id,
                                              OrganizerCubit
                                                  .get(context)
                                                  .allSponserListSelected,
                                              microsecondsSinceEpochStartDate,
                                              microsecondsSinceEpochEndDate,
                                              _controllersListOfMaxCapacity,
                                              _controllersListOfAvailableSeats
                                          );
                                        } else {
                                          keyScaffold.currentState
                                              .showSnackBar(const
                                          SnackBar(content: Text(
                                            "Please Add Time",
                                            style:
                                            TextStyle(color: Colors
                                                .white),),
                                            backgroundColor: Colors
                                                .blue,));
                                        }
                                      }
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
                                  }
                                }else{
                                  keyScaffold.currentState
                                      .showSnackBar(const
                                  SnackBar(content: Text(
                                    "Please Choose Countries And Categories And Sponsor",
                                    style:
                                    TextStyle(color: Colors
                                        .white),),
                                    backgroundColor: Colors
                                        .blue,));
                                }
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
              ),
            );
          },
          listener: (context, state) {},
        )
    );
  }
  Widget getLocationDesign(startDateController,endDateController,
      maxCapacityController,availableSeatsController,context,{index})
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getLang(context, "*Required");
                          }
                          return null;
                        },
                        onTap: (){
                          showDatePicker(context: context,
                            initialDate: DateTime.now().add(const Duration(hours: 1)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 10),
                          ).then((value) {

                             microsecondsSinceEpochStartDate.add(value.toUtc().millisecondsSinceEpoch~/1000);
                             print(value.toUtc().millisecondsSinceEpoch);
                            final DateFormat formatter = DateFormat('yyyy-MM-dd');
                            final String formatted = formatter.format(value);
                            startDateController.text=formatted;
                          });
                        },
                        style: const TextStyle(fontSize: 14),
                        controller: startDateController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          /*suffixIcon: IconButton(
                            icon: const Icon(Icons.delete_forever_outlined),
                            onPressed: () {
                              OrganizerCubit.get(context).deleteItemLoc(index);
                              _controllersThirdDesign.removeAt(index);
                              if (OrganizerCubit
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length > 0) {

                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    const SnackBar(content:
                                    Text("تم مسح جميع العناصر")));
                              }
                            },
                          ),*/
                          label:  Text(getLang(context, "Start Date")),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getLang(context, "*Required");
                          }
                          return null;
                        },
                        onTap: (){
                          showDatePicker(context: context,
                            initialDate: DateTime.now().add(const Duration(hours: 1)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 10),
                          ).then((value) {
                            microsecondsSinceEpochEndDate.add(value.toUtc().millisecondsSinceEpoch~/1000);
                            print(value.toUtc().millisecondsSinceEpoch);
                            final DateFormat formatter = DateFormat('yyyy-MM-dd');
                            final String formatted = formatter.format(value);
                            endDateController.text=formatted;
                          });
                        },
                        style: const TextStyle(fontSize: 14),
                        controller: endDateController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          /*suffixIcon: IconButton(
                            icon: const Icon(Icons.delete_forever_outlined),
                            onPressed: () {
                              OrganizerCubit.get(context).deleteItemLoc(index);
                              _controllersThirdDesign.removeAt(index);
                             */
                          /* if (OrganizerCubit
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length > 0) {

                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    const SnackBar(content:
                                    Text("تم مسح جميع العناصر")));
                              }*//*
                            },
                          ),*/
                          label:  Text(getLang(context, "End Date")),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getLang(context, "*Required");
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                        controller: maxCapacityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          label:  Text(getLang(context, "Max Capacity")),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getLang(context, "*Required");
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                        controller: availableSeatsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          label:  Text(getLang(context, "Available Seats")),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(onTap: (){
            if (OrganizerCubit
                .get(context)
                .itemsOfInformFieldLocation
                .length > 0) {
              microsecondsSinceEpochStartDate.length>index?microsecondsSinceEpochStartDate.removeAt(index):print("");
              microsecondsSinceEpochEndDate.length>index?microsecondsSinceEpochEndDate.removeAt(index):print("");
              _controllersListOfStartDate.removeAt(index);
              _controllersListOfEndDate.removeAt(index);
              _controllersListOfMaxCapacity.removeAt(index);
              _controllersListOfAvailableSeats.removeAt(index);
              OrganizerCubit.get(context).deleteItemLoc(index);
            } else {
              keyScaffold.currentState.showSnackBar(
                  const SnackBar(content:
                  Text("تم مسح جميع العناصر")));
            }
          }, child: const Icon(Icons.highlight_remove_sharp))
        ],
      ),
    );
  }
  void _showMultiSelect(BuildContext context) async {
    List<SponserModel> SponserModelList=[];
    SponserModelList.add(OrganizerCubit.get(context).allSponserList[0]);
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return  MultiSelectBottomSheet(
          items: OrganizerCubit.get(context).allSponserList.map((e) => MultiSelectItem(e, e.name)).toList(),
          initialValue: SponserModelList,
          searchable: true,
          listType: MultiSelectListType.LIST,
          initialChildSize: 0.5,
          onConfirm: (values) {
              OrganizerCubit.get(context).allSponserListSelectedAddEvent(values);
          },
          maxChildSize: 0.8,
        );
      },
    );
  }
}
