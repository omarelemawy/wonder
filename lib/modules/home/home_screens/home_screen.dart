import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer_image/shimmer_image.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/all_events.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_screens/search_screen.dart';
import 'item_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>HomeCubit()..getAll()..getNew(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=HomeCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(

                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/unsplash2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 220,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40,),
                          Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .01),
                              child: Image.asset(
                                'assets/wegather.png',
                                height: 60,
                                width: 80,
                              )),
                          Text(
                            getLang(context,
                                "From here you will find the most interesting places"),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 30),
                            child: TextFormField(
                              onTap: (){
                                _showSearchDialog(context);
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  filled: true,
                                label:Text(getLang(context, "Choose your destination"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13)),
                                fillColor: Colors.grey[300]
                              ),
                            ),
                          ),
                          /*Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .01),
                            child: Text(
                              'WANDER GUIDE',
                              style: TextStyle(
                                  letterSpacing: 10.0, color: Color(0xFFFE6B02)),
                            ),
                          )*/
                        ],
                      ),
                    ],
                  ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       const SizedBox(width: 10,),
                       Text(
                         getLang(context, "More Sharing"),
                         style: const TextStyle(
                             color: Colors.black,
                             fontSize: 14,
                             fontWeight: FontWeight.bold),
                       ),
                     ],
                   ),
                  cubit.allEventsList.isEmpty?const
                  Center(child:  CircularProgressIndicator()):
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        /*physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,*/
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context,index) => itemBuilder(cubit.allEventsList[index],context),
                        itemCount: cubit.allEventsList.length),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10,),
                      Text(
                        getLang(context, "New Events"),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  cubit.allNewList.isEmpty?const
                  Center(child:  CircularProgressIndicator()): SizedBox(
                    height: 350,
                    child: ListView.builder(
                      /*physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,*/
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context,index) => itemBuilder(cubit.allNewList[index],context),
                        itemCount: cubit.allNewList.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget itemBuilder(Events allEventsList,context)
{
  return SizedBox(
    width: 230,

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400],width: 1,)
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.only(topLeft: const Radius.circular(20),topRight: const Radius.circular(20)),
                  child: ProgressiveImage(
                    imageError:  "assets/unsplash2.jpg",
                    width: 220.0,
                    image: 'https://wanderguide.net/assets/site/images/events/${allEventsList.details.cover}',
                    height: 140.0,
                    fit: BoxFit.fill,

                  )/*Image.network(
                    'https://wanderguide.net/assets/site/images/events/${allEventsList.details.cover}',
                    height: 110,
                    width: 210,
                    fit: BoxFit.cover,
                  ),*/
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${allEventsList.details.price} SR",style:
                  const TextStyle(color: Colors.white,fontSize: 14,
                      shadows: <Shadow>[
                         Shadow(
                          blurRadius:10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                         Shadow(
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                      fontWeight: FontWeight.bold), ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocale.of(context).myLang(context)=="en"?
                    allEventsList.details.titleEn:allEventsList.details.titleAr,
                    style:const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)
                    ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                  const SizedBox(height: 5,),
                  Text(
                    AppLocale.of(context).myLang(context)=="en"?
                    allEventsList.details.descriptionEn:
                    allEventsList.details.descriptionAr,
                    style:const TextStyle(color: Colors.black,fontSize: 12)
                    ,overflow: TextOverflow.ellipsis,maxLines: 2,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(allEventsList.details.type,
                        style:const TextStyle(color: Colors.black,fontSize: 14)
                        ,overflow: TextOverflow.ellipsis,maxLines: 1,),
                      const SizedBox(width: 5,),
                      CircleAvatar(backgroundColor:
                      allEventsList.details.type=="offline"?Colors.black:Colors.green,radius: 3,)
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(allEventsList.likes.toString(),style:
                      const TextStyle(color: Colors.deepOrange,fontSize: 12,fontWeight: FontWeight.bold), ),
                      Image.asset("assets/like.png",height: 25,width: 25,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showDataDialog(
                                context, allEventsList.dates);
                          },
                          child: Text(getLang(context, "View Appointments"),style: TextStyle(color: Colors.white,fontSize: 10),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrange),
                          ),
                        ),
                      ),
                      SizedBox(width: 3,),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsDetails(allEventsList.details.id)));
                          },
                          child: Text(getLang(context, "view details"),style: TextStyle(color: Colors.deepOrange,fontSize: 10)),
                          style: ButtonStyle(),

                        ),
                      ),
                    ],
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


Future<void> _showSearchDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    // user must tap button!
    builder: (BuildContext context) {
      var formKey = GlobalKey<FormState>();
      TextEditingController _startDateController = TextEditingController();
      TextEditingController _cityController = TextEditingController();
      TextEditingController _categoryDateController = TextEditingController();
      TextEditingController _endDateController = TextEditingController();
      return BlocProvider(
        create:(context)=>HomeCubit(),
        child: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder: (context,state){
            return Dialog(
              child: SizedBox(
                height: 400,
                width: double.infinity,
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: _cityController..text=HomeCubit.get(context).city,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10),
                                    child: DropdownButton<String>(
                                      hint: Text(getLang(context, "Choose the city")),
                                      value: HomeCubit.get(context).city,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                      iconSize: 30,
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.black),
                                      onChanged: (String newValue) {
                                        HomeCubit.get(context).changeCity(newValue);
                                      },
                                      items: <String>[
                                        'cairo',
                                        'Alex',
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return  DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                textAlign: TextAlign.left,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                    child: DropdownButton<String>(
                                      hint: Text(getLang(context, "Choose category")),
                                      value: HomeCubit.get(context).category,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                      iconSize: 30,
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.black),
                                      underline: const SizedBox(),
                                      onChanged: (String newValue) {
                                       HomeCubit.get(context).changeCategory(newValue);
                                      },
                                      items: <String>[
                                        'entertainment',
                                        'Fair',
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                textAlign: TextAlign.left,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                  border: const OutlineInputBorder()),
                              controller: _categoryDateController..text=HomeCubit.get(context).category,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: TextFormField(
                                     onTap: (){
                                       showDatePicker(context: context,
                                           initialDate: DateTime.now(),
                                           firstDate:DateTime.now() ,
                                           lastDate: DateTime.utc(2090)).then((value) {
                                         _startDateController.text=intl.DateFormat.yMMMd().format(value);
                                       });
                                     },
                                      controller: _startDateController,
                                      decoration: InputDecoration(
                                        labelText: getLang(context, "start in"),
                                        suffixIcon: const Icon(Icons.date_range),
                                        border: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20))
                                        )
                                      ),
                                    ),
                                    height: 40,
                                  ),
                                  const SizedBox(height: 20,),
                                  SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      onTap: () {
                                        showDatePicker(context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.utc(2090)).then((
                                            value) {
                                          _endDateController.text =
                                              intl.DateFormat.yMMMd().format(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: getLang(context, "Expires in"),
                                        suffixIcon: const Icon(Icons.date_range),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                        )
                                      ),
                                      controller: _endDateController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom:30,top: 40),
                              width: 200,
                              height: 40,
                              child: RaisedButton(
                                  color: const Color(0xFFFE4B02),
                                  shape: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (context)=>
                                                SearchScreen(_cityController.text,
                                                    _categoryDateController.text,_startDateController.text,
                                                    _endDateController.text
                                                )));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        getLang(context, "search"),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      );
    },
  );

}

Future<void> _showDataDialog(context, List<Dates> data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 400,
          width: double.infinity,
          child: data.isEmpty ? Center(child:
          Text(getLang(context, "No dates"),
            style: TextStyle(color: Colors.black, fontSize: 20),)) :
          ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(getLang(context, "start in"), style: TextStyle(
                                        color: Colors.black, fontSize: 16),),
                                    const Text( " : ",
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 16),),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text("${data[index].startDate} ",
                                    style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height: 2, color: Colors.deepOrangeAccent,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(getLang(context, "Expires in"), style: TextStyle(
                                        color: Colors.black, fontSize: 16),),
                                    const Text( " : ",
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 16),),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text("${data[index].endDate}",
                                    style: const TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 2, color: Colors.deepOrangeAccent,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(getLang(context, "availableSeats"), style: TextStyle(
                                        color: Colors.black, fontSize: 16),),
                                    const Text( ":",
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 16),),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text("${data[index].availableSeats} ",
                                    style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      );
    },
  );
}