import 'package:flutter/material.dart';
import 'package:wander_guide/componants/app_locale.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272C48),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: () {
           Navigator.of(context).pop();
        },),
        title: Text(getLang(context, "who are we"),style:
        TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/wegather.png',
              height: 90,
              width: 140,
              fit: BoxFit.fill,
            ),
             Container(
               padding: EdgeInsets.only(right: 20,left: 20),
               child: Column(
                 children: [
                   Text(
                     getLang(context, "our mission"),
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 40,
                         fontWeight: FontWeight.bold),
                   ),
                   Text(
                     getLang(context, "Shape the future of delivering great live experiences by creating easy and accessible plate form to link passionate people with creative organizers")
                     ,style: TextStyle(color: Colors.white, fontSize: 16
                     ),
                   ),
                   Text(
                     getLang(context, "who are we"),
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 40,
                         fontWeight: FontWeight.bold),
                   ),
                   Text(
                     getLang(context, "WanderGuide is an international platform for live experiences that provide organizers with manage, advertise and online ticket selling services to passionate people whom want to fuel their passion, enhance their lives and discovering new things. From Yoga to bicycle, from the top of mountains to the deepest of the ocean, from music concert to the calm of the desert. WanderGuide welcome all kind of activities with easy access and fully activity management platform"),
                     style: TextStyle(color: Colors.white, fontSize: 16),
                   ),
                 ],
               ),
             ),
            Container(
              margin: EdgeInsets.only(top: 80),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFE4B02),
              ),
              child: Column(
                children: [
                  Text('تواصل معنا',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('0199937766 ',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('0199937766 ',
                      style: TextStyle(color: Colors.white, fontSize: 18))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
