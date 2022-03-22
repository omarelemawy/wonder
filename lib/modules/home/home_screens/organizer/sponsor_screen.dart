import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/model/sponser.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/add_sponsor_screen.dart';
import 'package:wander_guide/modules/home/home_screens/organizer/bloc/cubit_organizer.dart';

import '../item_details.dart';
import 'bloc/state_organizer.dart';

class SponsorScreen extends StatelessWidget {
   SponsorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>OrganizerCubit()..getMySponser(),
      child: BlocConsumer<OrganizerCubit,OrganizerStates>(
         builder: (context,state){
           var cubit=OrganizerCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               centerTitle: true,
               title: Text(
                 getLang(context, "Sponsor"),
                 style: const TextStyle(color: Colors.white),
               ),
             ),
             floatingActionButton: FloatingActionButton.extended(onPressed: ()
             {
               Navigator.push(context, MaterialPageRoute(builder:
                   (context)=>AddSponsorScreen()));
             }, label: Row(
               children: [
                  Text(getLang(context, "Add Sponsor"),style:const TextStyle(color: Colors.white),),
                 const SizedBox(width: 5,),
                 const Icon(Icons.add,color: Colors.white,)
               ],
             )),
             body: Column(
               children: [
                 state is GetSponsersLoadingOrganizerStates?const
                 Center(child:  CircularProgressIndicator()):
                 Expanded(
                   child: ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemBuilder:(context,index) => itemBuilder(cubit.allSponserList[index],context),
                       itemCount: cubit.allSponserList.length),
                 )
               ],
             ),
           );
         },
        listener: (context,state){},
      )
    );
  }
  Widget itemBuilder(SponserModel allEventsList,context)
  {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: Image.network(
                  'https://wanderguide.net/assets/site/images/sponsors/${allEventsList.logo}',
                  height: 190,
                  width: 160,
                  fit: BoxFit.fill,
                  errorBuilder: (context,ss,cc){
                    return  ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10),
                        child: Image.asset(
                            "assets/unsplash2.jpg",
                          height: 190,
                          width: 160,
                          fit: BoxFit.fill,
                        ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end
                        ,children: [
                        DropdownButton(
                          underline: const SizedBox(),
                          icon: const Icon(Icons.view_headline_outlined,color: Colors.black,),
                          items: Sponser.languageList(context).map<DropdownMenuItem<Sponser>>
                            ((lang) => DropdownMenuItem<Sponser>(
                            value: lang,
                            child: Row(
                              children: [
                                Text(lang.name,style: const TextStyle(fontSize: 14),),
                                const SizedBox(width: 1,),
                              ],
                            ),
                          )
                          ).toList(),
                          onChanged: (value){
                            OrganizerCubit.get(context).changeOrganizerDeleteAndEdit(context,value.id,allEventsList.id);
                              },
                        ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:
                            [
                              Text(getLang(context, "Name :"),
                               style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)
                               ,overflow: TextOverflow.ellipsis,maxLines: 1,),

                            ],
                          ),
                          Text(allEventsList.name,
                            style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)
                            ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text(getLang(context, "Email :"),
                                style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)
                                ,overflow: TextOverflow.ellipsis,maxLines: 1,),

                            ],
                          ),
                          Text(allEventsList.email,
                            style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)
                            ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text(getLang(context, "Phone :"),
                                style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)
                                ,overflow: TextOverflow.ellipsis,maxLines: 1,),

                            ],
                          ),
                          Text(allEventsList.mobile,
                            style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)
                            ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          const SizedBox(height: 8,),
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