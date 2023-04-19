import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


class about extends StatefulWidget {
  late String title;

  // Profile(String s);

  @override
  _aboutState createState() => _aboutState();
}


final nameController = TextEditingController();
final emailController = TextEditingController();
final addressController = TextEditingController();
final passController = TextEditingController();
final phoneController = TextEditingController();
final roleController = TextEditingController();

class _aboutState extends State<about> {


  //Future<FirebaseAuth>  _future = FirebaseAuth.instance.currentUser as Future<FirebaseAuth>;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body:


        ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 10.0),
                child:
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 110.0),
                child:
                Text('who we are', style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent
                ),
                ),
              ),
              SizedBox(height: 78.0),
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 199.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.0))
                  ),
                  child:

                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('About').snapshots(),
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
                                                      Icon(Icons.info,
                                                        color: Colors
                                                            .lightBlueAccent,)
                                                      , Text('About the ministry ',
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
                                                    padding: EdgeInsets.only(
                                                        left: 23.0),
                                                    child: new Text(
                                                      data['about the ministry'],
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),

                                                  )
                                              ),

                                              SizedBox(height: 10.0),

                                              ListTile(
                                                  title: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.visibility_outlined,
                                                        color: Colors
                                                            .lightBlueAccent,)
                                                      , Text('Our Vision ',
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
                                                    padding: EdgeInsets.only(
                                                        left: 23.0),
                                                    child: Text(data['our vision'],
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),),

                                                  )
                                              ),

                                              SizedBox(height: 10.0),
                                              ListTile(
                                                  title: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.filter_center_focus,
                                                        color: Colors
                                                            .lightBlueAccent,)
                                                      , Text('The mission of the Church',
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight: FontWeight
                                                                .w500),
                                                       // maxLines: 3,
                                                      )
                                                      ,
                                                    ],
                                                  ),
                                                  subtitle:
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 23.0),
                                                    child: Text(
                                                      data['mission'],
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),

                                                  )
                                              ),
                                              SizedBox(height: 30.0),
                                              ListTile(
                                                  title: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.contact_page,
                                                        color: Colors
                                                            .lightBlueAccent,)
                                                      , Text('Contact info',
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight: FontWeight
                                                                .w500),
                                                     //   maxLines: 3,
                                                      )
                                                      ,
                                                    ],
                                                  ),
                                                  subtitle:
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 23.0),
                                                    child: Text(data['contact'],
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),

                                                  )
                                              ),
                                              SizedBox(height: 30.0)


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