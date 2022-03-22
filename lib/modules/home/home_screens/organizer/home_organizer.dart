import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wander_guide/componants/app_locale.dart';

class HomeOrganizer extends StatefulWidget {
  const HomeOrganizer({Key key}) : super(key: key);

  @override
  _HomeOrganizerState createState() => _HomeOrganizerState();
}

class _HomeOrganizerState extends State<HomeOrganizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(getLang(context, "Home"),style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
             Text(getLang(context, "statistics"),style: TextStyle(color: Colors.grey[900],fontSize: 22),),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
              child:Row(
                children: [
                   Text("5",style: TextStyle(color: Colors.grey[800],fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                   Text(getLang(context, "Event"),style: TextStyle(color: Colors.grey[800],fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ) ,
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[900]
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Text("1020202",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(getLang(context, "Sponsor"),style: TextStyle(color: Colors.white,fontSize: 20),),
                      ],
                    ) ,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[900]
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text("1020202",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                         Text(getLang(context, "tickets left"),style: TextStyle(color: Colors.white,fontSize: 20),),
                      ],
                    ) ,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
