
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/model/events_details.dart';
import 'package:wander_guide/model/favorite.dart';
import 'package:wander_guide/model/new_model.dart';
import 'package:wander_guide/model/profile_model.dart';
import 'package:wander_guide/model/search_model.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_screens/favorite_screen.dart';
import 'package:wander_guide/modules/home/home_screens/home_screen.dart';
import 'package:wander_guide/modules/home/home_screens/my_reservations.dart';
import 'package:wander_guide/modules/home/home_screens/new_screen.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/add_events.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/bloc/cubit_organizer.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/events.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/home_organizer.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/profileScreenOrganizer.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/sponsor_screen.dart';
import 'package:wander_guide/modules/home/home_screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:wander_guide/modules/login/singin_screen.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

import '../../../main.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Events> allEventsList=[];
  List<Events> allNewList=[];
  List<SearchModel> searchList=[];
  List<ProfileModel> profileList=[];
  List<FavEvents> favList=[];
  int bottomNevIndex = 0;
  int bottomNevIndexOrganizer = 2;
  List<int> favListId=[];

  List<Widget> homeListScreen = [
    HomeScreen(),
    FavoriteScreen(),
    MyReservations(),
    NewScreen(),
    ProfileScreen(),
  ];
  List<Widget> homeListScreenOrganizer = [
    EventsScreen(),
    SponsorScreen(),
    HomeOrganizer(),
    AddEvents(),
    ProfileScreenOrganizer()
  ];
  void getImage() {
    emit((GetImageEditProfileStates()));
  }

  void changeBottomNevIndex(index) {
    switch (index) {
      case 0:
        getAll();
        break;
      case 1:
        getFavData();
        break;
    /*  case 4:
        getProfile();
        break;*/
    }
    bottomNevIndex = index;
    emit(ChangeBottomNevHomeStates());
  }
  void changeBottomNevIndexOrganizer(index) {
    switch (index) {

    }
    bottomNevIndexOrganizer = index;
    emit(ChangeBottomNevHomeStatesOrganizer());
  }


  Future<List<Events>> getAllEvents() async {
    emit(GetLoadingMostSharingDataHomeStates());
    var Api = Uri.parse("https://wanderguide.net/api/events");
    final response = await http.get(Api);
    if (response.statusCode == 200) {
      emit(GetSuccessMostSharingDataHomeStates());
      var decode = json.decode(response.body);
      final parsed = decode["data"]["events"].cast<Map<String, dynamic>>();
      return parsed.map<Events>((item) => Events.fromJson(item)).toList();
    } else {
      var body = response.body;
      emit(GetErrorMostSharingDataHomeStates(body));
    }
  }

  void getAll() {
    getAllEvents().then((value) {
      allEventsList = value;
    });
  }

 /* Future<List<Events>> getAllNewEvents() async {
    emit(GetLoadingMostSharingDataHomeStates());
    var Api = Uri.parse("https://wanderguide.net/api/newestEvents");
    final response = await http.get(Api);
    if (response.statusCode == 200) {
      emit(GetSuccessMostSharingDataHomeStates());
      var decode = json.decode(response.body);
      final parsed = decode["data"]["events"].cast<Map<String, dynamic>>();
      return parsed.map<Events>((item) => Events.fromJson(item)).toList();
    } else {
      var body = response.body;
      emit(GetErrorMostSharingDataHomeStates(body));
    }
  }

  void getAllNew() {
    getAllNewEvents().then((value) {
      allEventsList = value;
    });
  }*/

  Future<List<Events>> getAllnewest() async {
    emit(GetLoadingNewDataHomeStates());
    var Api = Uri.parse("https://wanderguide.net/api/newestEvents");
    final response = await http.get(Api);
    if (response.statusCode == 200) {
      emit(GetSuccessNewDataHomeStates());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Events>((item) => Events.fromJson(item)).toList();
    } else {
      emit(GetErrorNewDataHomeStates(response.body));
      print(response.body);
    }
  }

  void getNew() {
    getAllnewest().then((value) {
      allNewList = value;
      print(value[0].details.titleAr);
    });
  }

  Future<List<ProfileModel>> getPrfileData() async
  {
    print("ff");
    emit(GetLoadingProfileDataHomeStates());
    var APIURL = Uri.parse('https://wanderguide.net/api/profile');
    Map mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
    };
    http.Response response = await http.post(APIURL, body: mapData);
    final parsed = json.decode(response.body);
    if (parsed =="Token is invalid, User is not authenticated") {
      print("error");
      emit(GetErrorProfileDataHomeStates(response.body));
      print(parsed);

    } else if(response.statusCode == 200){
      print(parsed.toString()+"xxxxxxxxxxxxxxxxxxx");
      emit(GetSuccessProfileDataHomeStates());
      return parsed.map<ProfileModel>((item) => ProfileModel.fromJson(item))
          .toList();
    }
  }

  void getProfile() {
    getPrfileData().then((value) {
      profileList = value;
    });
  }

  Future logoutUser(context) async {
    emit(LogOutLoadingStates());
    var token = CacheHelper.getData(key: 'remember_token');
    var APIURL = Uri.parse('https://wanderguide.net/api/logout');
    Map mapData = {
      'token': token,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    print(response.body);
    if (response.statusCode == 200) {
      emit(LogOutSuccessStates());
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
              (context) => false);
      CacheHelper.removeData(key: 'remember_token');
    } else {
      emit(LogOutErrorStates(response.body));
    }
  }

  bool isLike = false;

  void getIsLike(id) async
  {
    if (isLike == false) {
      var APIURL = Uri.parse("https://wanderguide.net/api/like");
      Map mapData = {
        "token": CacheHelper.getData(key: "remember_token"),
        'event_id': id,
      };
      http.Response response = await http.post(APIURL, body: mapData);
      if (response.statusCode == 200) {
        emit(GetSuccessEventDetailDataHomeStates());
        var parsed = json.decode(response.body);
        isLike = true;
        emit(GetIsLikeStates());
      } else {
        var body = response.body;
      }
    }
  }

  void getIsDisLike(id) async
  {
    if (isLike) {
      print(id);
      var APIURL = Uri.parse("https://wanderguide.net/api/dislike");
      Map mapData = {
        "token": CacheHelper.getData(key: "remember_token"),
        'id': id,
      };
      http.Response response = await http.post(APIURL, body: mapData);
      if (response.statusCode == 200) {
        var parsed = json.decode(response.body);
        print(parsed);
        isLike = false;
        emit(GetIsLikeStates());
      } else {
        var body = response.body;
      }
    }
  }

  EventsDetail eventsDetail;

  Future<EventsDetails> getEventDetails(id) async {
    print(id);
    emit(GetLoadingEventDetailDataHomeStates());
    var APIURL = Uri.parse("https://wanderguide.net/api/viewEventDetails");
    Map mapData = {
      'event_id': id,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    if (response.statusCode == 200) {
      emit(GetSuccessEventDetailDataHomeStates());
      final Map<String, dynamic> parsed = json.decode(response.body);

      return EventsDetails.fromJson(parsed);
    } else {
      var body = response.body;
      emit(GetErrorEventDetailDataHomeStates(body));
    }
  }

  void getEvent(id) {
    print(id);
    getEventDetails(id).then((value) {
      eventsDetail = value.data.events;
      getFavData();
    });
  }

  Future sendComment(id, body) async {
    emit(SendCommentLoadingHomeStates());
    var APIURL = Uri.parse("https://wanderguide.net/api/add_comment");
    var token = CacheHelper.getData(key: 'remember_token');
    Map mapData = {
      "token": token,
      'event_id': id,
      "body": body
    };
    http.Response response = await http.post(APIURL, body: mapData);
    print(response.body);
    if (response.statusCode == 200) {
      emit(SendCommentSuccessHomeStates());
      getEvent(id);
    } else {
      var body = response.body;
    }
  }

/*  Future<List<ProfileModel>> editPrfileData() async
  {
    emit(GetLoadingProfileDataHomeStates());
    var APIURL = Uri.parse('https://wanderguide.net/api/profile');
    Map mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
    };
    http.Response response = await http.post(APIURL, body: mapData);
    if (response.statusCode == 200) {
      emit(GetSuccessProfileDataHomeStates());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<ProfileModel>((item) => ProfileModel.fromJson(item))
          .toList();
    } else {
      emit(GetErrorProfileDataHomeStates(response.body));
    }
  }*/

  String city;
  String category;

  void changeCity(myCity) {
    city = myCity;
    emit(ChangeCityHomeStates());
  }

  void changeCategory(myCategory) {
    category = myCategory;
    emit(ChangeCityHomeStates());
  }

  Future<List<SearchModel>> getSearchEvents(city, category) async {
    emit(GetLoadingSearchDataHomeStates());
    var Api = Uri.parse("https://wanderguide.net/api/search");
    Map data = {
      'city': city,
      'owner': category,
      'event_start_date': "",
      'event_end_date': ''
    };
    final response = await http.post(Api, body: data);
    if (response.statusCode == 200) {
      emit(GetSuccessSearchDataHomeStates());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<SearchModel>((item) => SearchModel.fromJson(item))
          .toList();
    } else {
      emit(GetErrorSearchDataHomeStates(response.body));
      print(response.body);
    }
  }

  void getSearch(city, category) {
    getSearchEvents(city, category).then((value) {
      searchList = value;
    });
  }

  Future<FavoriteModel> getFavoriteData() async
  {
    emit(GetLoadingFavoriteDataHomeStates());
    var APIURL = Uri.parse(
        'https://wanderguide.net/api/userEventsFavoriteList');
    Map mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
    };
    http.Response response = await http.post(APIURL, body: mapData);
    if (response.statusCode == 200) {
      emit(GetSuccessFavoriteDataHomeStates());
      final Map<String, dynamic> parsed = json.decode(response.body);
      return FavoriteModel.fromJson(parsed);
    } else {
      emit(GetErrorFavoriteDataHomeStates(response.body));
    }
  }

  void getFavData() {
    getFavoriteData().then((value) {
      favList = value.events;
      for (var element in favList) {
        favListId.add(element.id);
      }
      if(eventsDetail !=null) {
        for (var element in favListId) {
          if (element == eventsDetail.details[0].details1.id) {
             isLike = true;
            }
          }
      }
    });
  }

  Future editProfile(fname, lname, email, phone, img) async
  {
    emit(GetLoadingEditProfileHomeStates());
    Map<String, String> mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
      "fname": fname,
      "lname": lname,
      "email": email,
      "phone": phone,
    };
    var APIURL = Uri.parse('https://wanderguide.net/api/profile/update');
    var request = http.MultipartRequest("POST", APIURL);
    if (img != null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img', img.path);
      request.files.add(multipartFile);
    }
    request.fields.addAll(mapData);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        var data = jsonDecode(value);
        print(data.toString());
      });
      emit(GetSuccessEditProfileHomeStates());
    } else {
      response.stream.transform(utf8.decoder).listen((value) {
        var data = jsonDecode(value);
        emit(GetErrorEditProfileHomeStates(data.toString()));
      });
    }
  }

  Future sendMail(email, massageBody, massage) async
  {
    emit(SendMailLoadingStates());
    Map<String, String> mapData = {
      'token': CacheHelper.getData(key: "remember_token"),
      "email": email,
      "massage_body": massageBody,
      "massage": massage,
    };
    var APIURL = Uri.parse('https://wanderguide.net/api/contact');
    var request = http.MultipartRequest("POST", APIURL);
    request.fields.addAll(mapData);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        var data = jsonDecode(value);
        print(data.toString());
      });
      emit(SendMailSuccessStates());
    } else {
      response.stream.transform(utf8.decoder).listen((value) {
        var data = jsonDecode(value);
        emit(SendMailErrorStates(data.toString()));
      });
    }
  }

  Icon choseLikeState(LikeStates states)
{
  Icon icon;
  switch(states)
  {
    case LikeStates.FIRSTLIKE:
      icon= const Icon(Icons.favorite, color: Colors.red,);
      break;
    case LikeStates.ISNOTLIKE:
       icon= const Icon(Icons.favorite_border, color: Colors.white,);
      break;
    case LikeStates.ISLIKE:
     icon = const Icon(Icons.favorite, color: Colors.red,);
      break;
  }
  return icon;
 }
  void changeLang(context,int index){
    Locale locale;
    switch(index){
      case 1:
        locale =  const Locale("en","US");
        break;
      case 2:
        locale =  const Locale("ar","EG");
        break;
    }
    MyApp.setLocale(context, locale);
    emit(LangChangeHomeState());
  }
  bool commentState = false;
  void changeCommentState(){
    commentState = !commentState;
    emit(ChangeCommentState());
  }
}

enum LikeStates{FIRSTLIKE,ISNOTLIKE,ISLIKE}

