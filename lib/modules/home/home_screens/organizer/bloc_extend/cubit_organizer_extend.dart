import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wander_guide/modules/home/home_screens/organizer/bloc_extend/state_organizer_extend.dart';



class OrganizerCubitExtend extends Cubit<OrganizerStatesExtend>{
  OrganizerCubitExtend() : super(InitialOrganizerExtendStates());
  static OrganizerCubitExtend get(context) => BlocProvider.of(context);
  var statisticsOrganizer;

  Future getAllStatistics() async {
    emit(GetLoadingOrganizerStatisticsStates());
    var Api = Uri.parse("https://wanderguide.net/api/Statistics");

    final response = await http.get(Api);

    var decode = json.decode(response.body);

    if(response.statusCode == 200) {
      emit(GetSuccessOrganizerStatisticsStates());
      final parsed = decode;
      statisticsOrganizer=parsed;
      return parsed;

    } else {
      var body = response.body;
      emit(GetErrorOrganizerStatisticsStates());
    }
  }

}