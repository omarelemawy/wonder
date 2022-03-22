import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/model/events_details.dart';
import 'package:wander_guide/modules/home/bloc/cubit.dart';
import 'package:wander_guide/modules/home/bloc/states.dart';
import 'package:wander_guide/modules/home/home_layout.dart';

class ItemsDetails extends StatelessWidget {
  int id;

  ItemsDetails(this.id, {Key key}) : super(key: key);
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getEvent(id.toString()),
      child: BlocConsumer<HomeCubit, HomeStates>(
          builder: (context, state) {
            EventsDetail eventDetail = HomeCubit.get(context).eventsDetail;
            return WillPopScope(
              onWillPop: (){
                return  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                    (context)=>HomeLayout()), (route) => false);
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                          (context)=>HomeLayout()), (route) => false);
                    },),
                  actions: [
                    IconButton(icon: HomeCubit
                        .get(context)
                        .isLike ?
                        HomeCubit.get(context).choseLikeState(LikeStates.ISLIKE) :
                        HomeCubit.get(context).choseLikeState(LikeStates.ISNOTLIKE),
                      onPressed:
                          () {
                        if (HomeCubit.get(context).isLike)
                        {
                          HomeCubit.get(context).getIsDisLike(id.toString());
                        }
                        else {
                          HomeCubit.get(context).getIsLike(id.toString());
                        }
                      },),
                    IconButton(
                      icon: Icon(Icons.save_alt, color: Colors.white,),),
                  ],
                  elevation: 0,
                  centerTitle: true,
                  title: state is GetLoadingEventDetailDataHomeStates ? const
                  Center(child:
                  CircularProgressIndicator()) :
                  Text(
                    AppLocale.of(context).myLang(context)=="en"?
                    eventDetail.details[0].details1.titleEn:
                    eventDetail.details[0].details1.titleAr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                ),
                body: state is GetLoadingEventDetailDataHomeStates ? const
                Center(
                    child: CircularProgressIndicator()) :
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              'https://wanderguide.net/assets/site/images/events/${eventDetail
                                  .details[0].details1.cover}',
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              'assets/wegather.png',
                              height: 50,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 20, left: 20, bottom: 10),
                        child: Text(
                          AppLocale.of(context).myLang(context)=="en"?
                          eventDetail.details[0].details1.descriptionEn:
                          eventDetail.details[0].details1.descriptionAr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                           padding: EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25))
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              onPressed: () {
                                _showDataDialog(
                                    context, eventDetail.details[0].dates);
                              },
                              child: Text(getLang(context, "Date"), style: TextStyle(color:
                              Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25))
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              onPressed: () {
                                _showSponsorsDialog(
                                    context, eventDetail.sponsors);
                              },
                              child: Text(getLang(context, "sponsors"), style: TextStyle(color:
                              Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25))
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              onPressed: () {
                                _showOwnerDialog(context, eventDetail.owner);
                              },
                              child: Text(getLang(context, "owner"), style: TextStyle(color:
                              Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(color:Colors.grey,height: 2,width: double.infinity,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/like.png", height: 40, width: 40,),
                            SizedBox(width: 5,),
                            Text(eventDetail.details[0].likes.toString(), style:
                            TextStyle(color: Colors.deepOrange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),),
                            SizedBox(width: 70,),
                            Text(
                              eventDetail.details[0].details1.type.toString(),
                              style:
                              TextStyle(color: Colors.deepOrange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),),
                            SizedBox(width: 10,),
                            CircleAvatar(backgroundColor:
                            eventDetail.details[0].details1.type == "offline"
                                ? Colors.black
                                : Colors.green, radius: 3,)
                            ,SizedBox(width:70,),
                            IconButton(icon:const Icon(Icons.share,color: Colors.deepOrange,),
                              onPressed: () {
                                share(
                                    eventDetail.details[0].siteLink,
                                    AppLocale.of(context).myLang(context)=="en"?
                                    eventDetail.details[0].details1.titleEn:
                                    eventDetail.details[0].details1.titleAr,
                                    AppLocale.of(context).myLang(context)=="en"?
                                    eventDetail.details[0].details1.descriptionEn:
                                    eventDetail.details[0].details1.descriptionAr,
                                    context);
                              },)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(color:Colors.grey,height: 2,width: double.infinity,),
                      Container(
                        height: 240,
                        width: double.infinity,
                        color: HexColor("#020630"),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, right: 30,left: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.all(1),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      /*image: DecorationImage(image: AssetImage("assets/wegather.png",))*/
                                      color:HexColor("#ff8902"),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(child: Image.asset(
                                      "assets/wegather.png",
                                      fit: BoxFit.cover,)),
                                  ),
                                  SizedBox(width: 15,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("WANDER GUIDE", style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Container(width: 80,
                                        height: 4,
                                        color: Colors.white,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 25,),
                              Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green,),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(
                                      getLang(context, "Follow the instructions and take care of public etiquette"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                      TextStyle(color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green,),
                                  SizedBox(width: 5,),
                                  Text(getLang(context, "Agree to the terms and conditions"), style:
                                  TextStyle(color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 30, right: 30, bottom: 10),
                        child: Row(
                          children: [
                            Text("SR", style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),),
                            SizedBox(width: 5,),
                            Text(eventDetail.details[0].details1.price,
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange[800],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25))
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: MaterialButton(
                                onPressed: () {},
                                child: Text(getLang(context, "Book now"), style: TextStyle(color:
                                Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(child: Text(getLang(context, "Comments"), style: TextStyle(
                          color: Colors.black, fontSize: 18),)),
                      SizedBox(height: 10,),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            commentsBuilder(eventDetail.comments[index]),
                        itemCount: HomeCubit.get(context).commentState==false?
                        eventDetail.comments.length<2?eventDetail.comments.length:2:
                        eventDetail.comments.length,
                      ),
                      GestureDetector(
                        onTap: (){
                         HomeCubit.get(context).changeCommentState();
                        },
                        child: Container(
                          color: Colors.grey,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Text(!HomeCubit.get(context).commentState?
                               getLang(context, "Show More Comments"):getLang(context, "Show Less Comments"),style:
                               const TextStyle(color: Colors.white,fontSize: 11),),
                               Icon(!HomeCubit.get(context).commentState?
                               Icons.arrow_drop_down:Icons.arrow_drop_up,
                                 color: Colors.white,size: 14,)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        padding: EdgeInsets.all(5),
                        child: Card(
                          elevation: 20,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: getLang(context, "Comment"),
                                  ),
                                  onFieldSubmitted: (value) {
                                    HomeCubit.get(context).sendComment(
                                        id.toString(), value.toString()).then((
                                        value) {
                                      commentController.text = "";
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }, listener: (context, state) {}),
    );
  }

  Widget commentsBuilder(Comments comments) {
    return Container(
        padding: const EdgeInsets.all(3),
        color: Colors.grey,
        child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(comments.userId.img,),
                        backgroundColor: Colors.deepOrangeAccent, radius: 25,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          comments.userId.name,
                          style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 60),
                      Expanded(
                        child: Container(
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                            child: Text(comments.body,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
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

  Future<void> _showOwnerDialog(context, Owner owner) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
              height: 300,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://wanderguide.net/assets/site/images/events/${owner
                          .img}',
                    ),
                    radius: 40,

                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(getLang(context, "name"), style: const TextStyle(
                                color: Colors.black, fontSize: 16),),
                            const Text( " : ",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 16),),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Expanded(
                            child: Text("${owner.fname}  ${owner.lname}",
                              style: const TextStyle(color: Colors.deepOrangeAccent,
                                  fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2, color: Colors.deepOrangeAccent,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(getLang(context, "Email"), style: TextStyle(
                                color: Colors.black, fontSize: 16),),
                            const Text( " : ",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 16),),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text("${owner.email}", style: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2, color: Colors.deepOrangeAccent,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(getLang(context, "Phone"), style: TextStyle(
                                color: Colors.black, fontSize: 16),),
                            const Text( " : ",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 16),),
                          ],
                        ),
                      SizedBox(width: 10,),
                        Expanded(
                          child: Text("${owner.phone} ", style: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  Future<void> _showSponsorsDialog(context, List<Sponsors> sponsors) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400,
            width: double.infinity,
            child: sponsors.isEmpty ?  Center(child:
            Text(getLang(context, "No Sponsors"),
              style: const TextStyle(color: Colors.black, fontSize: 20),)) :
            ListView.builder(
                itemCount: sponsors.length,
                itemBuilder: (context, index) =>
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://wanderguide.net/assets/site/images/events/${sponsors[index]
                                      .logo}',
                                ),
                                radius: 25,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                           Row(
                                             children: [
                                               Text(getLang(context, "name"),
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 16),),
                                               const Text( " : ",
                                                 style: TextStyle(color: Colors.black,
                                                     fontSize: 16),),
                                             ],
                                           ),
                                          Expanded(
                                            child: Text("${sponsors[index].name}",
                                              style: const TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container( height: 2, color: Colors.deepOrangeAccent,),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text( getLang(context, "Email"),
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 16),),
                                              const Text( " : ",
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 16),),
                                            ],
                                          ),
                                          Expanded(
                                            child: Text("${sponsors[index].email}  ",
                                              style: const TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(height: 2, color: Colors.deepOrangeAccent,),
                                      SizedBox(height: 10,),

                                      Row(
                                        children: [
                                           Row(
                                             children: [
                                               Text(getLang(context, "Phone")
                                                ,style: const TextStyle(color: Colors.black,
                                                    fontSize: 16),),
                                               const Text( " : ",
                                                 style: TextStyle(color: Colors.black,
                                                     fontSize: 16),),
                                             ],
                                           ),
                                          Expanded(
                                            child: Text("${sponsors[index].mobile}  ",
                                              style: const TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        );
      },
    );
  }
  Future<void> share(url,title,body,context) async {
    await FlutterShare.share(
        title: title,
        text: body,
        linkUrl: url,
        chooserTitle: getLang(context, "Where You Want To Share")
    );
  }
}
