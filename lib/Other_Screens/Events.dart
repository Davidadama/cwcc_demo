import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';



final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


class events extends StatefulWidget {
  //final String title;
  //const events(String s,  {required Key key, required this.title}) : super(key: key);

  @override
  _eventsState createState() => _eventsState();
}


class _eventsState extends State<events> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Events',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListPage(),

    );
  }
}

class ListPage extends StatefulWidget
{

  @override
  _ListPageState createState() => _ListPageState();

}

/**final errandController = TextEditingController();
    final descriptionController = TextEditingController();
    final timeController = TextEditingController();
    final payController = TextEditingController();
    final locationController = TextEditingController();
    final mobileController = TextEditingController();
 **/


class _ListPageState extends State<ListPage>
{
 // get index => null;


  navigateToDetail(DocumentSnapshot events){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(events: events)));
  }
  late String userID;

  late final  User _user;
  late final DocumentSnapshot? userInfo;

  @override
  void initState() {
    super.initState();
    _currentUser().whenComplete((){
      setState(() {
      }
      );
    });
  }

  _currentUser() async {
    _user = FirebaseAuth.instance.currentUser! ;
    try {
      userInfo = await FirebaseFirestore.instance
          .collection('Events')
          .doc(_user.uid)
          .get().whenComplete(() => userID = _user.uid );
      // userID = userInfo as String;

    } catch (e) {
      print("something went wrong");
    }
  }
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore
      .instance.collection('Events').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
        child:

          StreamBuilder(
                      stream: _usersStream,
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
                              Map<String, dynamic> data = document
                                  .data() as Map<String, dynamic>;

                              Widget popupMenuButton() {
                                return PopupMenuButton<String>(

                                    icon: Icon(Icons.more_vert,
                                      color: Colors.lightBlue,
                                      size: 25.0,),
                                    itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[

                                      PopupMenuItem<String>(
                                          value: '1',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.update,
                                                color: Colors.lightBlue,),
                                              Text('Duration')
                                            ],
                                          )
                                      ),
                                      PopupMenuItem<String>(
                                          value: '2',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.person_add_sharp,
                                                color: Colors.lightBlue,),
                                              Text('Special guest(s)'),
                                            ],
                                          )

                                      ),
                                      PopupMenuItem<String>(
                                          value: '3',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.home_filled,
                                                color: Colors.lightBlue,),
                                              Text('host')
                                            ],
                                          )
                                      ),
                                      PopupMenuItem<String>(
                                          value: '4',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.question_answer,
                                                color: Colors.lightBlue,),
                                              Text('Description')
                                            ],
                                          )
                                      ),
                                      PopupMenuItem<String>(
                                          value: '5',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on_outlined,
                                                color: Colors.lightBlue,),
                                              Text('location')
                                            ],
                                          )
                                      ),
                                      PopupMenuItem<String>(
                                          value: '6',
                                          child:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.access_time,
                                                color: Colors.lightBlue,),
                                              Text('program time')
                                            ],
                                          )
                                      )

                                    ],
                                    onSelected: (retValue) {
                                      if (retValue == '1') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text('duration',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),

                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(data['date']
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }
                                      if (retValue == '2') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text('Special guest(s)',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),
                                                  content: Row(
                                                    children: [
                                                      Text(data['special_guest'],
                                                        style: TextStyle(
                                                            fontSize: 17
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }
                                      if (retValue == '3') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text('host',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),

                                                  scrollable: true,
                                                  content: Column(
                                                    children: [
                                                      Text(data['host']
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }
                                      if (retValue == '4') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text(
                                                      'description',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),
                                                  scrollable: true,
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                          data['description']
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  //color: Colors.blue
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }
                                      if (retValue == '5') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text(
                                                      'location',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),
                                                  scrollable: true,
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                          data['location']
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                               //   color: Colors.blue
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }
                                      if (retValue == '6') {
                                        showDialog(context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text(
                                                      'program time',
                                                      style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 20,
                                                      )),
                                                  scrollable: true,
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                          data['time']
                                                      )
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                    context)
                                                                // ignore: missing_return
                                                                    .pop(),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                              ),)
                                                        ),
                                                        SizedBox(
                                                          height: 60.0,)
                                                      ],
                                                    ),

                                                  ],
                                                )
                                        );
                                      }

                                    }
                                );
                              }
                              return ListTile(
                                onTap: () {navigateToDetail(snapshot.data!.docs.first);},
                                title: Text(data['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.0,
                                  ),
                                ),

                                subtitle: Text(data[
                                    'date'], style: TextStyle(
                                  color: Colors.lightBlue
                                )),
                                trailing:
                                popupMenuButton(),
                              );
                            }
                            ).toList()
                        );
                      }
                  )
    );
                }

              }


class DetailPage extends StatefulWidget {
  final DocumentSnapshot events;

  DetailPage({required this.events});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Event Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              color: Colors.white,
            ),
          ),
        ),
        body:
        Container(
            child:
            ListView(
                children: <Widget>[
                  Column(
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.details, color: Colors.lightBlue,)
                                , Text('Description',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('description'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.date_range_outlined, color: Colors.lightBlue,)
                                , Text('Date',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('date'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.access_time_outlined, color: Colors.lightBlue,)
                                , Text('Time',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('time'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.location_on_outlined, color: Colors.lightBlue,)
                                , Text('Location',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('location'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.people_alt_sharp, color: Colors.lightBlue,)
                                , Text('Special guest(s)',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('special_guest'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),
                        SizedBox(height: 5.0),
                        ListTile(
                            title: Row(
                              children: <Widget>[
                                Icon(Icons.home, color: Colors.lightBlue,)
                                , Text('Host',
                                  style: TextStyle(
                                      fontSize: 17.0,fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                )
                                ,],
                            ),
                            subtitle:
                            Padding(padding: EdgeInsets.only(left:23.0),
                              child: Text(widget.events.get('host'),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),),

                            )
                        ),

                      ]
                  ),
                ]
            )
        ));

  }
}

