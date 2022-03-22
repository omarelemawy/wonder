import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';

import 'item_details.dart';

class SearchScreen extends StatelessWidget {
  String city,category,start,end;

  SearchScreen(this.city,this.category,this.start,this.end, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context)=>HomeCubit()..getSearch(city,category),
        child: BlocConsumer<HomeCubit,HomeStates>(
            listener:(context,state){},
          builder: (context,state){
            var cubit=HomeCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title:  Text(getLang(context, "search"), style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
                ),
                body:state is GetLoadingSearchDataHomeStates?Center(child: const CircularProgressIndicator()):
                ListView.builder(
                    itemCount: cubit.searchList.length,
                    itemBuilder:(context,index)=>GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> ItemsDetails(cubit.searchList[index].details.id)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(20),
                              child: Image.network(
                                'https://wanderguide.net/assets/site/images/events/${cubit.searchList[index].details.cover}',
                                height: 160,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocale.of(context).myLang(context)=="en"?
                                      cubit.searchList[index].details.titleEn:cubit.searchList[index].details.titleAr,
                                      style:TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold)
                                      ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                    SizedBox(height: 2,),
                                    Text(
                                      AppLocale.of(context).myLang(context)=="en"?
                                      cubit.searchList[index].details.descriptionEn:
                                      cubit.searchList[index].details.descriptionAr,
                                      style:TextStyle(color: Colors.black,fontSize: 14)
                                      ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text(
                                          cubit.searchList[index].details.type,
                                          style:TextStyle(color: Colors.black,fontSize: 14)
                                          ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                        SizedBox(width: 5,),
                                        CircleAvatar(backgroundColor:
                                        cubit.searchList[index].details.type=="offline"?Colors.black:Colors.green,radius: 3,)
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.deepOrange[800],
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Text(getLang(context, "get with wander guide"),style: TextStyle(
                                          color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Image.asset("assets/like.png",height: 25,width: 25,),
                                        Text(cubit.searchList[index].likes.toString(),style:
                                        TextStyle(color: Colors.deepOrange,fontSize: 12,fontWeight: FontWeight.bold), ),
                                        Spacer(),
                                        Text("${cubit.searchList[index].details.price} SR",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold), ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
          },
        )
    );
  }
}
