import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {

   HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=HomeCubit.get(context);
          return CacheHelper.getData(key: 'isOrganizer')==true?
          Scaffold(
            body: cubit.homeListScreenOrganizer[cubit.bottomNevIndexOrganizer],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottomNevIndexOrganizer(index);
              },
              currentIndex: cubit.bottomNevIndexOrganizer,
              elevation: 50,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.event),label: getLang(context, "Event")),
                BottomNavigationBarItem(icon: Icon(Icons.support_outlined),label: getLang(context, "Sponsor")),
                BottomNavigationBarItem(icon: Icon(Icons.home),label: getLang(context, "Home")),
                BottomNavigationBarItem(icon: Icon(Icons.my_library_add_outlined),label: getLang(context, "Create Event")),
                BottomNavigationBarItem(icon: Icon(Icons.person,),label: getLang(context, "Profile")),
              ],
            ),
          ):
          Scaffold(
            body: cubit.homeListScreen[cubit.bottomNevIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottomNevIndex(index);
              },
              currentIndex: cubit.bottomNevIndex,
              elevation: 50,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.search),label: getLang(context, "Discover")),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: getLang(context, "Favorite")),
                BottomNavigationBarItem(icon: Icon(Icons.work_outline_outlined),label: getLang(context, "My reservations")),
                BottomNavigationBarItem(icon: Icon(Icons.add_business_outlined,),label: getLang(context, "New")),
                BottomNavigationBarItem(icon: Icon(Icons.person,),label: getLang(context, "Profile")),
              ],
            ),
          );
        },
      )
    );
  }
}
