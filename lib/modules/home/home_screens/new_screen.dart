import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/model/new_model.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_screens/item_details.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>HomeCubit()..getNew(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title:  Text(getLang(context, "New"), style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
              ),
              body:  Column(
                children: [
                  SizedBox(height: 4,),
                  Expanded(
                    child:state is GetLoadingNewDataHomeStates?
                    const Center(child: CircularProgressIndicator()): ListView.separated(
                        itemBuilder: (context,index)=>itemBuilder(cubit.allNewList[index],context),
                        separatorBuilder: (context,index)=>
                            Container(color: Colors.grey[500] ,height: 2,),
                        itemCount: cubit.allNewList.length),
                  ),
                ],
              )
          );
        },
      )
    );
  }

 Widget itemBuilder(Events newModel,context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsDetails(newModel.details.id)));
      },
      child: Container(
        height: 180,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Row(
          children: [
            Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.all(1),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)),
                ),
                child: Image.network(
                  'https://wanderguide.net/assets/site/images/events/${newModel.details.cover}',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )),
            SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 7,),
                    Text(
                      AppLocale.of(context).myLang(context)=="en"?
                      newModel.details.titleEn:newModel.details.titleAr,
                      style:const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)
                      ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                    Text(
                      AppLocale.of(context).myLang(context)=="en"?
                      newModel.details.descriptionEn:newModel.details.descriptionAr,
                      style:const TextStyle(color: Colors.black,fontSize: 14)
                      ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                    const SizedBox(height: 7,),
                    Row(
                      children: [
                        Text(newModel.details.type,
                          style:TextStyle(color: Colors.black,fontSize: 14)
                          ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                        SizedBox(width: 5,),
                        CircleAvatar(backgroundColor:
                        newModel.details.type=="offline"?Colors.red:Colors.green,radius: 3,)
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      children: [
                        Image.asset("assets/like2.png",height: 25,width: 25,),
                        SizedBox(width: 3,),
                        Text(newModel.likes.toString(),style:
                        TextStyle(color: Colors.deepOrange,fontSize: 14,fontWeight: FontWeight.bold), ),
                        Spacer(),
                        /*Text("${newModel.details.price}  SR",
                          style:TextStyle(color: Colors.black,fontSize: 11)
                          ,overflow: TextOverflow.ellipsis,maxLines: 1,),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CircleAvatar(backgroundColor: Colors.blue,radius: 7,)
          ],
        ),
      ),
    );
  }
}
