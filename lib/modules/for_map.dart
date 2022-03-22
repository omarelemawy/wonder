

import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();

  static Future<void> openMap(double lat,double lon)
  async{
   String googleUrl= "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
   if(await canLaunch(googleUrl)){
     await launch(googleUrl);
   }else{
     throw "Can't open the Map";
   }
  }
}