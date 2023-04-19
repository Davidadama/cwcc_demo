import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


class pastors extends StatefulWidget {
  late String title;

  // Profile(String s);

  @override
  _pastorsState createState() => _pastorsState();
}


final nameController = TextEditingController();
final emailController = TextEditingController();
final addressController = TextEditingController();
final passController = TextEditingController();
final phoneController = TextEditingController();
final roleController = TextEditingController();

class _pastorsState extends State<pastors> {


  //Future<FirebaseAuth>  _future = FirebaseAuth.instance.currentUser as Future<FirebaseAuth>;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        body:


        ListView(

            children: <Widget>[
              Container(

        decoration: BoxDecoration(
          shape: BoxShape.circle,
            image: DecorationImage(

            fit: BoxFit.fitHeight,
           // colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.8), BlendMode.dstATop),
            image:
            AssetImage('assets/images/Pastor-Dunka-Gomwalk-300x300.jpg')
        ),

    ),
       height: 205.0,
              ),
              Padding(
                padding: EdgeInsets.only( top: 0.0),
                child:
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Padding(
                      padding: EdgeInsets.only( left: 75.0),
                      child:
                      Text('Our pastors', style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                      ),
                    ),

                  ],
                ),
              ),
             // SizedBox(height: 10.0),
                           SizedBox(height: 20.0),
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 295.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.0))
                  ),
                  child:

                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('pastors').snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              )
                          );
                        }

                        return new ListView(
                          children: snapshot.data!.docs.map((
                              DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<
                                String,
                                dynamic>;

                            return Container(
                                child:
                                Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child:
                                        Column(
                                            children: <Widget>[
                                              SizedBox(height: 10.0),

                                              ListTile(
                                                  title: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.info_sharp,
                                                        color: Colors
                                                            .lightBlue,)
                                                      , Text('Pastor Dunka Joseph Gomwalk',
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight: FontWeight
                                                                .w500),
                                                        maxLines: 3,
                                                      )
                                                      ,
                                                    ],
                                                  ),
                                                  subtitle:
                                                  Padding(
                                                    padding: EdgeInsets.only( top: 10.0,
                                                        left: 23.0),
                                                    child: new Text(
                                                      data['pastors'],
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),

                                                  )
                                              ),

                                              SizedBox(height: 30.0),



                                            ]
                                        ),
                                      ),
                                    ]
                                )

                            );
                          }
                          ).toList(),
                        );
                      }


                  )
              )
            ]
        ));
  }
}