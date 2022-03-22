import 'package:flutter/material.dart';
import 'package:wander_guide/componants/app_locale.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272C48),
         appBar:  AppBar(
           leading: IconButton(
             icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
             onPressed: (){
               Navigator.of(context).pop();
             },
           ),
           centerTitle: true,
           elevation: 00,
           title: Text(getLang(context, "Privacy Policies"),
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
                        child: Text(getLang(context, "WanderGuide store and collect personal information from your account in our platform depending of what required"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                        maxLines: 3,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                      ),
                      Expanded(
                        child: Text(getLang(context, "Transparncy is our policy and we guarantee you the confidentiality of all your information registered with us in line with our policy"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 3,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Personal Information"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 3,),
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
                        child: Text(getLang(context, "Name, email, phone number, age and location"),
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
                          getLang(context, "Additional information may asked as required"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Google Account information"),
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
                        child: Text(getLang(context, "No additional information will be collected from your google accont"),
                          style: const TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70,
                      ),
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
                        child: Text(getLang(context, "All information will be privately saved"),
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
                          getLang(context, "Users can choose to hide or public their information"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(radius: 3,backgroundColor: Colors.grey,),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Data resulting from the operations and services provided"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70,
                      ),
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
                          getLang(context, "No identity would be realesed"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                          getLang(context, "The purpose of using the collected information"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                     children: [
                       SizedBox(width: 100,),
                       Expanded (
                         child: Text(
                           getLang(context, "Improve the quality of customer service"),
                           style: TextStyle(color: Colors.white,fontSize: 16),
                           maxLines: 2,),
                       ),
                     ],
                   ),
                  SizedBox(height: 10,),
                  Row(
                     children: [
                       SizedBox(width: 100,),
                       Expanded(
                         child: Text(
                           getLang(context, "Optimizing applications with every update to suit your aspirations"),
                           style: TextStyle(color: Colors.white,fontSize: 16),
                           maxLines: 3,),
                       ),
                     ],
                   ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 100,),
                      Expanded(
                        child: Text(
                          getLang(context, "Sending electronic messages periodically"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 3,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                          getLang(context, "Limits for disclosing personal user information"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                     children: [
                       const SizedBox(width: 100,)
                       ,Expanded(
                         child: Text(
                          getLang(context, "Personal information will not be used for any other purpose than to complete the transaction with you, except in the following cases"),
                           style: TextStyle(color: Colors.white,fontSize: 16),
                           maxLines: 2,),
                       ),
                     ],
                   ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 110,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                        child: Container(
                          height: 6.5,width: 6.5,decoration:
                        BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "After taking your permission"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 110,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                        child: Container(
                          height: 6.5,width: 6.5,decoration:
                        BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Share it with companies and stores to provide offers on products and services, with your permissions"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 110,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                        child: Container(
                          height: 6.5,width: 6.5,decoration:
                        BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Disclosure to the competent authorities if requested due to the illegal use of the application"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 110,)
                      ,Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                        child: Container(
                          height: 6.5,width: 6.5,decoration:
                        BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context, "Special circumstances such as summons or court orders"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 110,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                        child: Container(
                          height: 6.5,width: 6.5,decoration:
                        BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),),
                      ),
                      Expanded(
                        child: Text(
                          getLang(context,
                              "In the event ownership of the platform or application is transferred to another company, the ownership of the information will be transferred"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                          getLang(context, "Ensuring Privacy by WanderGuide"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                     children: [
                       SizedBox(width: 100,),
                       Expanded(child:Text(
                         getLang(context, "The user, whether an individual or a company, is granted a full authority and authorization of the application or it’s representative to use the personal information registered by the user in the application as well as the data generated by the processes of this application"),
                         style: TextStyle(color: Colors.white,fontSize: 16),
                         maxLines: 2,),
                       )
                     ],
                   ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 100,),
                      Expanded(
                        child: Text(
                          getLang(context, "WanderGuide guarantee not sell, rent or share your personal information to any third party except as provided in this Privacy Policy")
                         ,
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 100,),
                      Expanded(
                        child: Text(
                          getLang(context, "After deleting your account in any platform or application, your registered personal information will be deleted immediately, unless you give permission to keep it within the closing steps"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                          getLang(context, "Acceptance of Privacy Policy Terms"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 100,),
                      Expanded(
                        child: Text(
                          getLang(context, "Giving WanderGuide your full approval of the privacy policy. If you do not agree on this policy, you should not use our service.fter deleting your account in any platform or application, your registered personal information will be deleted immediately, unless you give permission to keep it within the closing steps"),
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
                          getLang(context, "Changes and Update on Privacy Policy"),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                      getLang(context, "WanderGuide has the right to update this privacy policy at any time. We recommend that you should review the privacy policy frequently to check any changes")
                          ,
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          maxLines: 2,),
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
