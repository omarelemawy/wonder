import 'package:flutter/material.dart';
import 'package:wander_guide/componants/app_locale.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272C48),
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 00,
        title:  Text(getLang(context, "Terms and Conditions"),
          style: TextStyle(color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "These terms and conditions applies to all agreement concluded between organizers / partners and users through WanderGuide platform"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "All data supplied to WanderGuide must be truthful. The organizers have the right to cancel the agreement or exclude users from having the service and to demand compensation amounting to cancellation costs, if the user provides defective details"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines:4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Users and organizers must arrive at the meeting point on time all necessary precautions must be taken example passport for traveling abroad"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Organizers have the right to add more Terms and Conditions in their agreement with users and users have to follow their agreement details. The organizers have the right to exclude any users not complying with their conditions"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "When user book a ticket the ticket or agreement comes to be binding when you receive the ticket or confirming email within 5 working days"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Payment due when buy tickets or upon receiving confirming email"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Service agreement with the organizers will be collected from the payment")
                      ,
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "WanderGuid will collect payments on behalve of the organizers"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "All prices will include taxes and any extra fees"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "To use WanderGuide payment services the user has to register"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "WanderGuide has the right to cancel or remove any activities not complains with local and international conditions"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "The requirement for insurance upon the booked activity"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "All messages between users and organizers have to be done through WanderGuide Platform"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Cancellation"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Up to 24 hours before the start of the activity: Fully funded"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Less than 24 hours or no show: non-refundable"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "The Organizer has the right to apply his own refunding conditions"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(
                    getLang(context, "Refund through the same payment method as possible"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 70,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                    child: Container(
                      height: 6.5,width: 6.5,decoration:
                    BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),),
                  ),
                  Expanded(
                    child: Text(getLang(context, "Organizers can cancel their activities or event due to external conditions in this case all costs are refundable"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                     getLang(context, "All Terms and conditions are subjected to changes or updates without notice for future booking"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Some Parteners are included in these booking services with official contracts"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Intermediate partner makes a booking on behalf of a user should be concluded between the end user and organizer"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "Users and Organizers should keep their registration data secret"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                  ),
                  Expanded(
                    child: Text(
                      getLang(context, "WanderGuide used data for creating contract between users and organizers"),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      maxLines: 4,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
