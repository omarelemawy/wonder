import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';

class OrganizersScreen extends StatelessWidget {
  const OrganizersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=> HomeCubit(),
        child: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder:  (context,state){
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title:  Text(getLang(context, "organizers"), style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
              ),
            );
          },
        ),
    );
  }
}
