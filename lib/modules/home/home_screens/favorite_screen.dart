
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/favorite.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_layout.dart';
import 'package:wander_guide/modules/home/home_screens/item_details.dart';

class FavoriteScreen extends StatelessWidget {
   FavoriteScreen({Key key}) : super(key: key);
  GlobalKey<ScaffoldState> _key= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()..getFavData(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetErrorFavoriteDataHomeStates)
              {
                _key.currentState.showSnackBar(SnackBar(content: Text(state.error.toString())));
              }
          },
          builder: (context, state) {
            return Scaffold(
                key: _key,
                appBar: AppBar(
                  elevation: 0,
                   centerTitle: true,
                  title:  Text(getLang(context, "Favorite"), style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
                  actions: [
                    IconButton(onPressed: () {
                      HomeCubit.get(context).changeBottomNevIndex(0);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) =>  HomeLayout()),
                            (route) => false,);
                    }, icon: Icon(Icons.add, color: Colors.white,))
                  ],
                ),
                body:state is GetLoadingFavoriteDataHomeStates?Center(child: const CircularProgressIndicator()) :
                ListView.builder(itemBuilder:
                    (context,index)=>itemBuilder(HomeCubit.get(context).favList[index],context),
                  itemCount: HomeCubit.get(context).favList.length,),
            );
          },
        )
    );
  }

  Widget itemBuilder(FavEvents favEvents,context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder:
                (context)=>ItemsDetails(favEvents.id)));
      },
      child: Stack(
        alignment:Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20)),
            ),
            child: Image.network("https://wanderguide.net/assets/site/images/events/${favEvents.cover}",
              fit: BoxFit.cover,),
          ),
          Container(
            margin:EdgeInsets.all(20) ,
            width: double.infinity,
            height: 50,
            color: Colors.grey[800],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8,right: 15),
                  child: Text(
                    AppLocale.of(context).myLang(context)=="en"?
                    favEvents.titleEn:
                    favEvents.titleAr,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Spacer(),
                Icon(Icons.chevron_right_rounded,size: 30,color: Colors.white,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
