import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/model/categories_model.dart';
import 'package:wander_guide/model/countries_model.dart';
import 'package:wander_guide/model/sponser.dart';
import 'package:wander_guide/modules/home/home_layout.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/add_sponsor_screen.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/bloc/state_organizer.dart';
import 'package:http/http.dart' as http;
import 'package:wander_guide/modules/home/home_screens/organizer/edit_event_sponsers.dart';
import 'package:wander_guide/modules/login/singin_screen.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

import '../../home_screen.dart';


class OrganizerCubit extends Cubit<OrganizerStates>{
  OrganizerCubit() : super(InitialOrganizerStates());
  static OrganizerCubit get(context) => BlocProvider.of(context);
  List<Widget> itemsOfInformFieldLocation=[];
  List<CategoriesModel> AllCategoriesList=[];
  List<Events> allEventsList;
  List<SponserModel> allSponserList=[];

  List<SponserModel> allSponserListSelected=[];

  List<CountriesModel> allCountriesList=[];


  int indexOnlineModeAddEvent =1;

  CategoriesModel indexCategoriesAddEvent ;

  SponserModel indexSponsorAddEvent ;

  CountriesModel indexCountriesAddEvent ;

  String dataOfLocationAddEvent="";


  Future<List<Events>> getAllEvents() async {
    emit(GetLoadingOrganizerEventsStates());
    var Api = Uri.parse("https://wanderguide.net/api/organizerEvents");
    Map mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
    };
    final response = await http.post(Api,body: mapData);

    var decode = json.decode(response.body);

    print(CacheHelper.getData(key: "remember_token"));
    if(decode=="Token is invalid, User is not authenticated") {
      var body = response.body;
      emit(GetErrorOrganizerEventsStates(body));
    } else if (decode["status"] == true) {
      emit(GetSuccessOrganizerEventsStates());
      final parsed = decode["data"]["events"];
      return parsed.map<Events>((item) => Events.fromJson(item)).toList();
    }

  }

  void changeLang(context,int index,id){

    switch(index){
      case 1:
        removeEvent(id);
        break;
      case 2:
         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditEventSponsor()));
        break;
    }

  }
  void changeOrganizerDeleteAndEdit(context,int index,id){

    switch(index){
      case 1:
        removeSponsor(id);
        break;
      case 2:
         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditEventSponsor()));
        break;
    }

  }


  void removeEvent(id) async {
    print(id);
    print(CacheHelper.getData(key: 'remember_token'));
    emit(RemoveEventLoadingStates());
    Map<String, dynamic> postBody = {
      "token":CacheHelper.getData(key: 'remember_token'),
      "event_id": id.toString(),
    };
    var Api = Uri.parse("https://wanderguide.net/api/orgEvents/delete/hisEvents");
    final response = await http.post(Api,body: postBody);
    final json = jsonDecode(response.body);
    if (json["status"] == true) {

      print(json);
      Fluttertoast.showToast(msg: "Event Deleted");
      getAll();
      emit(RemoveEventSuccessStates());

    } else {
      print(json["msg"]);
      emit(RemoveEventErrorStates('msg'));
    }
  }



  void removeSponsor(id) async {
    print(id);
    print(CacheHelper.getData(key: 'remember_token'));
    emit(RemoveSponsorLoadingStates());
    Map<String, dynamic> postBody = {
      "token":CacheHelper.getData(key: 'remember_token'),
      "event_id": id.toString(),
    };
    var Api = Uri.parse("https://wanderguide.net/api/orgEvents/sponsors/delete");
    final response = await http.post(Api,body: postBody);
    final json = jsonDecode(response.body);
    if (json["status"] == true) {
      print(json);
      Fluttertoast.showToast(msg: "Sponsor Deleted");
      getMySponser();
      emit(RemoveSponsorSuccessStates());

    } else {
      print(json["msg"]);
      emit(RemoveSponsorErrorStates('msg'));
    }
  }


  void getAll() {
    getAllEvents().then((value) {
      allEventsList = value;
    });
  }

  void getImageFirstDesign()
  {
    emit(GetImageAddSponsorState());
  }
  void addItemLoc(Widget widget)
  {
    itemsOfInformFieldLocation.add(widget);
    emit(AddIteOfInformLocState());
  }
  void addItemAddEvent(Widget widget)
  {
    itemsOfInformFieldLocation.add(widget);
    emit(AddIteOfInformLocState());
  }
  void deleteItemLoc(index)
  {
    print(index);
    itemsOfInformFieldLocation.removeAt(index);
    emit(DeleteIteOfInformLocState());
  }

  void addSponserCubit(context,photo,name,email,mobile) async {
    emit(AddSponsorLoadingStates());

    Map<String, String> postBody = {
      "token":CacheHelper.getData(key: 'remember_token'),
      "name": name,
      "email": email,
      "mobile": mobile,
    };
    var APIURL = Uri.parse("https://wanderguide.net/api/organizer/get/sponsers/add");
    var request =  http.MultipartRequest("POST", APIURL);
    print(photo);
    if(photo!=null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'images[]', photo.path,filename:basename(photo.path) );
      request.files.add(multipartFile);
    }
    Map<String, String> mapData = {
      'token': CacheHelper.getData(key: "token"),
    };
    request.fields.addAll(postBody);
    request.headers.addAll(mapData);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      if (data["status"] == true) {
        print(value);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeLayout()), (route) => false);

        emit(AddSponsorSuccessStates());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(AddSponsorErrorStates('msg'));
      }
    });
  }

  Future<List<SponserModel>> getSponserss() async {
    emit(GetSponsersLoadingOrganizerStates());
    var Api = Uri.parse("https://wanderguide.net/api/organizer/get/sponsers/view");

    final response = await http.get(Api);

    var decode = json.decode(response.body);
    if (response.statusCode == 200) {
      emit(GetSponsersSuccessOrganizereStates());

      print(decode);
      final parsed = decode.cast<Map<String, dynamic>>();
      return parsed.map<SponserModel>((item) => SponserModel.fromJson(item)).toList();
    } else {
      var body = response.body;
      emit(GetSponsersErrorOrganizereStates(body));
    }

  }



  void getMySponser() {
    getSponserss().then((value) {
      allSponserList = value;
    });
  }


  void addEventCubit(context,photo,title_en,title_ar,description_ar,
      description_en,price,type,lng,lat,url,address_id,
      category_id,List<SponserModel> sponsor,
      List<int>datesStart,
      List<int>datesEnd,
      List<TextEditingController>maxCapacity,
      List<TextEditingController>availableSeats)
  async {
    print(maxCapacity.length);
    emit(AddEventLoadingStates());
    List<String> sposorList=[];
    sponsor.forEach((element) {
      sposorList.add(element.id.toString());
    });
    var join = sposorList.join("|");

    List<String> datesStartList=[];
    datesStart.forEach((element) {
      datesStartList.add(element.toString());
    });
    var joindatesStart = datesStartList.join("|");

    List<String> datesEndList=[];
    datesEnd.forEach((element) {
      print(element);
      datesEndList.add(element.toString());
    });
    var joindatesEnd = datesEndList.join("|");

    List<String> maxCapacityList=[];
    maxCapacity.forEach((element) {
      print(element.text);
      if(element.text.toString() !="") {
        maxCapacityList.add(element.text.toString());
      }
    });
    var joinMaxCapacity = maxCapacityList.join("|");

    List<String> availableSeatsList=[];
    availableSeats.forEach((element) {
      if(element.text.toString()!="") {
        availableSeatsList.add(element.text.toString());
      }
    });
    var joinAvailableSeats = availableSeatsList.join("|");


    Map<String, String> postBody = {
      "token":CacheHelper.getData(key: 'remember_token'),
      "title_en": title_en,
      "title_ar": title_ar,
      "description_ar": description_ar,
      "description_en": description_en,
      "price": price,
      "type":type,
      "lng":lng,
      "lat":lat,
      "url":url,
      "address_id":address_id.toString(),
      "category_id":category_id.toString(),
      "sponsor[]":join,
      "datess_start[]":joindatesStart,
      "datess_end[]":joindatesEnd,
      "max_capacity[]":joinMaxCapacity,
      "available_seats[]":joinAvailableSeats,
    };
    var APIURL = Uri.parse("https://wanderguide.net/api/orgEvents");
    print(postBody);
    var request =  http.MultipartRequest("POST", APIURL);
    print(photo);
    if(photo!=null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'cover', photo.path,filename:basename(photo.path) );
      request.files.add(multipartFile);
    }
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {

      var data = jsonDecode(value);
      if (data["status"] == true) {
        print(data);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeLayout()), (route) => false);

        emit(AddEventSuccessStates());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(AddEventErrorStates('msg'));
      }
    });
  }
  Future logoutUser(context) async {
    emit(LogOutLoadingOrganizerStates());
    var token = CacheHelper.getData(key: 'remember_token');
    var APIURL = Uri.parse('https://wanderguide.net/api/logout');
    Map mapData = {
      'token': token,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    print(response.body);
    if (response.statusCode == 200) {
      emit(LogOutSuccessOrganizerStates());

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
              (context) => false);
      CacheHelper.removeData(key: 'remember_token');
    } else {
      emit(LogOutErrorOrganizerStates(response.body));
    }
  }

  void changeOnlineModeAddEvent(index)
  {
    indexOnlineModeAddEvent=index;
        emit(ChangeOnlineModeAddEventState());
  }

  void changeCategoriesAddEvent(index)
  {
    indexCategoriesAddEvent=index;
    emit(ChangeCategoriesAddEventState());
  }

  void changeLocationLatLong(data)
  {
         dataOfLocationAddEvent=data;
        emit(ChangeLocationAddEventState());
  }

  Future<List<CategoriesModel>> getAllCategories() async {
    emit(GetLoadingOrganizerCategoriesStates());
    var Api = Uri.parse("https://wanderguide.net/api/organizer/get/categories");

    final response = await http.get(Api);

    var decode = json.decode(response.body);

    print(CacheHelper.getData(key: "remember_token"));
    if(response.statusCode == 200) {
      emit(GetSuccessOrganizerCategoriesStates());
      final parsed = decode;
      return parsed.map<CategoriesModel>((item) => CategoriesModel.fromJson(item)).toList();

    } else {
      var body = response.body;
      emit(GetErrorOrganizerCategoriesStates(body));
    }
  }

   void getCatEvent(){
     getAllCategories().then((value){
       AllCategoriesList=value;
     });
   }

  void changeSponsorAddEvent(index)
  {
    indexSponsorAddEvent=index;
    emit(ChangeSponsorAddEventState());
  }

  void changeOrganizerCountriesLatLong(data)
  {
    indexCountriesAddEvent=data;
    emit(ChangeCountriesAddEventState());
  }

  Future<List<CountriesModel>> getAllCountries() async {
    emit(GetLoadingOrganizerCountriesStates());
    var Api = Uri.parse("https://wanderguide.net/api/organizer/get/countries");

    final response = await http.get(Api);

    var decode = json.decode(response.body);

    print(CacheHelper.getData(key: "remember_token"));
    if(response.statusCode == 200) {
      emit(GetSuccessOrganizerCountriesStates());
      final parsed = decode;
      return parsed.map<CountriesModel>((item) => CountriesModel.fromJson(item)).toList();

    } else {
      var body = response.body;
      emit(GetErrorOrganizerCountriesStates(body));
    }
  }

  void getAllCountriesEvent(){
    getAllCountries().then((value){
      allCountriesList=value;
    });
  }

  void allSponserListSelectedAddEvent(index)
  {
    allSponserListSelected.clear();
    allSponserListSelected.addAll(index);
    emit(AllSponserListSelectedAddEventState());
  }
  void removeSponserListSelectedAddEvent(index)
  {
    allSponserListSelected.remove(index);
    emit(RemoveSponsorListSelectedAddEventState());
  }





}