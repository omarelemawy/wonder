import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/bloc/cubit_organizer.dart';
import 'bloc/state_organizer.dart';
import 'events_more_inform_organizer.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>OrganizerCubit()..getAll(),
      child: BlocConsumer<OrganizerCubit,OrganizerStates>(
         builder: (context,state){
           var cubit=OrganizerCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               centerTitle: true,
               title: Text(
               getLang(context, "Event"),
                 style: TextStyle(color: Colors.white),
               ),
             ),
             body: state is GetLoadingOrganizerEventsStates?const
             Center(child:  CircularProgressIndicator()):Column(
               children: [
                 state is  GetErrorOrganizerEventsStates ?
                 Expanded(
                   child: Container(
                     width: double.infinity,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                          Text(getLang(context, "Log In Again Please"),style: TextStyle(fontSize: 20),),
                         SizedBox(height: 10,),
                         MaterialButton(onPressed: () {
                           cubit.logoutUser(context);
                         },
                           child:  Text(getLang(context, "Go"),
                             style: const TextStyle(color: Colors.white),),
                           color: Colors.deepOrange,)
                       ],
                     ),
                   ),
                 ):
                 Expanded(
                   child: ListView.builder(
                     /*physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,*/
                       scrollDirection: Axis.vertical,
                       itemBuilder:(context,index) => itemBuilder(cubit.allEventsList[index],context),
                       itemCount: cubit.allEventsList.length),
                 )
               ],
             ),
           );
         },
        listener: (context,state){},
      )
    );
  }
  Widget itemBuilder(Events allEventsList,context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> EventMoreInformOrganizer(allEventsList.details.id)));
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            shadowColor: Colors.blueAccent,
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(10),
                  child: ProgressiveImage(
                    imageError:  "assets/unsplash2.jpg",
                    width: 160.0,
                    fit: BoxFit.fill,
                    image: 'https://wanderguide.net/assets/site/images/events/${allEventsList.details.cover}',
                    height: 160.0,
                  )
              /*FadeInImage.assetNetwork(
                      placeholder: "assets/Wait.gif",
                      fit: BoxFit.fill,
                      height: 160,
                      width: 160,
                      imageCacheHeight: 160,
                      imageCacheWidth: 160,
                      placeholderFit:  BoxFit.fill,
                      image: 'https://wanderguide.net/assets/site/images/events/${allEventsList.details.cover}',
                      imageErrorBuilder: (context, ss, cc) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/unsplash2.jpg",
                            height: 160,
                            width: 160,
                            fit: BoxFit.fill,
                          ),
                        );
                      }
                  ),*/
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end
                          ,children: [
                          DropdownButton(
                            underline: SizedBox(),
                            icon: const Icon(Icons.view_headline_outlined,color: Colors.black,),
                            items: Sponser.languageList(context).map<DropdownMenuItem<Sponser>>
                              ((lang) => DropdownMenuItem<Sponser>(
                              value: lang,
                              child: Row(
                                children: [
                                  Text(lang.name,style: TextStyle(fontSize: 14),),
                                  const SizedBox(width: 1,),
                                ],
                              ),
                            )
                            ).toList(),
                            onChanged: (Sponser value){
                              OrganizerCubit.get(context).changeLang(context,value.id,allEventsList.details.id);
                            },
                          ),
                          SizedBox(width: 10,),
                        ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(AppLocale.of(context).myLang(context)=="en"?
                            allEventsList.details.titleEn:allEventsList.details.titleAr,
                              style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)
                              ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                            SizedBox(height: 8,),
                            Text(
                              AppLocale.of(context).myLang(context)=="en"?
                              allEventsList.details.descriptionEn:
                              allEventsList.details.descriptionAr,
                              style:TextStyle(color: Colors.black,fontSize: 12)
                              ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text(allEventsList.details.type,
                                  style:TextStyle(color: Colors.black,fontSize: 14)
                                  ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                SizedBox(width: 5,),
                                CircleAvatar(backgroundColor:
                                allEventsList.details.type=="offline"?Colors.black:Colors.green,radius: 3,)
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(Icons.price_check,color: Colors.deepOrange,size: 14,),
                                SizedBox(width: 10,),
                                Text("${allEventsList.details.price} SR",style:
                                const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold), ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Image.asset("assets/like.png",height: 25,width: 25,),
                                Text(allEventsList.likes.toString(),style:
                                TextStyle(color: Colors.deepOrange,fontSize: 12,fontWeight: FontWeight.bold), ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Sponser
{
  final String name;
  final int id;
  Sponser( this.name,this.id);

  static List<Sponser> languageList(context)
  {
    return [
      Sponser(getLang(context, "Delete"),1),
      Sponser(getLang(context, "Edit"),2)
    ];
  }
}
