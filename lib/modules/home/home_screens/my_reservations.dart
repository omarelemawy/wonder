import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:wander_guide/componants/app_locale.dart';

class MyReservations extends StatelessWidget {
  const MyReservations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          getLang(context, "My reservations"), style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0,left: 10,top: 20),
        child: ListView.builder(itemBuilder:
            (context,index)=>itemBuilder(context),
          itemCount: 2,),
      ),
    );
  }

 Widget itemBuilder(context) {
   return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.all( 20),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: HexColor("#0f1442"),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0,left: 15),
                child: DottedBorder(
                  color: Colors.white,
                  strokeWidth: .5,
                  child: Container(
                    height: 150,
                    width: 80,
                    margin: EdgeInsets.all(1),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)),
                      ),
                      child: Image.asset("assets/images.jpg",fit: BoxFit.cover,)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(getLang(context, "Sports Activities - Camel Riding"),
                         style: TextStyle(color: Colors.white,fontSize: 14),
                         overflow: TextOverflow.ellipsis,maxLines: 1,),
                       SizedBox(height: 5,),
                       Text(getLang(context, "Riyadh city"),style: TextStyle(color: Colors.white,fontSize: 14),
                         overflow: TextOverflow.ellipsis,maxLines: 1,),
                      SizedBox(height: 5,),
                      Text("4:30  - 9:00",style: TextStyle(color: Colors.white,fontSize: 14),
                         overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ), CircleAvatar(
          backgroundColor: Colors.orange[800],
          radius: 20,
          child: Icon(Icons.article,color: Colors.white,),
        ),
      ],
    );
 }
}
