import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwcc_demo_1/Other_Screens/About.dart';
import 'package:cwcc_demo_1/Other_Screens/Videos.dart';
import 'package:cwcc_demo_1/Other_Screens/pastors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AuthScreen/User_info.dart';
import 'AuthScreen/Welcome.dart';
import 'Other_Screens/Events.dart';
import 'Other_Screens/profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
User? status;

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    signInStatus().whenComplete((){
      setState(() {

      }
      );
    });
  }

  signInStatus() async{
    try{
      FirebaseAuth.instance.authStateChanges().listen((User? user) {status = user;}) ;
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cwcc demo1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      StreamBuilder(
          builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(status == null){
              return WelcomePage();
            }
            else return HomePage('title');
          }, stream: null,

      ),
      routes: <String, WidgetBuilder>{

        "/a": (BuildContext context) =>  Profile(),
        "/b": (BuildContext context) => HomePage("new page"),
        "/c": (BuildContext context) => about(),
           "/d": (BuildContext context) => pastors(),
        /**    "/f": (BuildContext context) => courses("title"),
            "/g": (BuildContext context) => syllabus("title"),  **/
      },

    );

  }
}
late String userID;
 String? _email, _displayName, _phoneNumber, _userRole;
late final DocumentSnapshot? userInfo;

late final  User _user = FirebaseAuth.instance.currentUser!;

class HomePage extends StatefulWidget {


  final String title;
  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? get title => null;


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
    try {
      userInfo = await FirebaseFirestore.instance
          .collection('User_information')
          .doc(_user.uid)
          .get().whenComplete(() => userID = _user.uid);

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          title:
          Text("cwcc demo 1", style: TextStyle(fontSize: 13.0,color:  Colors.white)),
          centerTitle: true,
        ),

        drawer: Drawer(

          child: ListView(
            children: <Widget>[

              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person),
                ),
                accountName: Text('name'),              //  ('$_displayName'),
                accountEmail: Text('$_email'),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.blue,
                    Colors.lightBlueAccent
                  ]
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.home,
                  color: Colors.lightBlue,
                ),
                title: Text('Home', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                onTap: () => Navigator.of(context).pushNamed('/b'),
              ),
              ListTile(
                title: Text('Profile', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.person,
                  color: Colors.lightBlue,),
                onTap: () => Navigator.of(context).pushNamed('/a'),
              ),
              ListTile(
                title: Text('Giving', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.monetization_on_sharp, color: Colors.lightBlue,),
               // onTap: () => Navigator.of(context).pushNamed('/c'),

              ),
              ListTile(
                title: Text('Notes', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.library_books_sharp, color: Colors.lightBlue,),
                //onTap: () => Navigator.of(context).pushNamed('/f'),
              ),
              ListTile(
                title: Text('Departments', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.tag, color: Colors.lightBlue,),
               // onTap: () => Navigator.of(context).pushNamed('/d'),
              ),
              ListTile(
                title: Text('About us', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.info_outline, color: Colors.lightBlue,),
                onTap: () => Navigator.of(context).pushNamed('/c'),
              ),
              ListTile(
                title: Text('Our Pastors', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal),),
                leading: Icon(Icons.people,color: Colors.lightBlue,),
                onTap: () => Navigator.of(context).pushNamed('/d'),
              ),

              ListTile(
                  title: Text('Close', style: TextStyle(
                      fontSize: 17.0, fontStyle: FontStyle.normal),),
                  leading: Icon(Icons.close, color: Colors.lightBlue,),
                  onTap: () => Navigator.of(context).pop()
              ),
              Divider(
                height: 20.0,
              ),

              ListTile(
                title: Text('Sign out', style: TextStyle(
                    fontSize: 17.0, fontStyle: FontStyle.normal,
                color: Colors.red
                ),),
                leading: Icon(Icons.logout, color: Colors.red,),
                onTap: _signOut,
              ),


            ],
          ),
        ),

        body:
                     ListView(
          children: <Widget>[
               Container(
                 decoration: BoxDecoration(
                     image: DecorationImage(
                       alignment: Alignment.topCenter,
                         fit: BoxFit.fill,
                       //  colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.2), BlendMode.dstATop),
                         image:
                         AssetImage('assets/images/IMG-20220418-WA0009.jpg')
                     ),
                     shape: BoxShape.rectangle,
                     color: Colors.lightBlue,
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(70.0),
                       bottomRight: Radius.circular(10.0),
                       bottomLeft: Radius.circular(90.0),
                     ),
                     border: Border(
                     )
                 ),
                 height: 299.0,
               ),
                SizedBox(height:80.0),

              Container(
                padding: EdgeInsets.only(right: 15.0,left: 15),
                width: MediaQuery.of(context).size.width - 70.0,
                height: MediaQuery.of(context).size.height - 70.0,
                child: GridView.count(crossAxisCount: 3,
                    primary: false,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.7,
                    children: <Widget>[
                      InkWell(
                        /**     onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>courses(title)))**/
                        child:
                        _buildCard('live Stream',
                            'assets/images/3673631.jpg',
                            context),
                      ),
                      InkWell(
                        /**  onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>questions(title)))  **/
                        child:
                        _buildCard('Messages',
                            'assets/images/vecteezy_priest-reading-the-holy-bible-and-stretching-his-hand_.jpg',
                            context),
                      ),
                      InkWell(
                     /**   onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>people())) ,**/
                        child:
                        _buildCard('Give',
                            'assets/images/11060.jpg',
                            context),
                      ),
                      InkWell(
                          onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>webView())),
                          child:
                          _buildCard('Videos',
                              'assets/images/5356687.jpg',
                              context)
                      ),
                      InkWell(
                        /**  onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>test(title))), **/
                          child:
                          _buildCard('Social',
                              'assets/images/4950546.jpg',
                              context)
                      ),
                      InkWell(
                        /**  onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>test(title))), **/
                          child:
                          _buildCard('Contact Us',
                              'assets/images/5124556.jpg',
                              context)
                      ),
                      InkWell(
                        /**  onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>test(title))), **/
                          child:
                          _buildCard('Prayer',
                              'assets/images/vecteezy_prayer-hands-gesture_.jpg',
                              context)
                      ),
                      InkWell(
                          onTap: () =>  Navigator.push(
                            context, MaterialPageRoute(builder: (context) => events())),
                          child:
                          _buildCard('Events',
                              'assets/images/vecteezy_marking-the-calendar-for-business-work-plans_.jpg',
                              context)
                      ),

                    ]

                ),
              ),


                      ]
                      )
    );
  }

  Future<void> _signOut() async{
    try {
      await FirebaseAuth.instance.signOut().whenComplete(() =>
          Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => WelcomePage()))
      );
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }


  Widget _buildCard(String name,String imgPath, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child:
        Container(
          /**  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3.0,
                      blurRadius: 3.0)
                ],
                color: Colors.white), **/
            child:
                  Card(
                    elevation: 7.0,
                      child:
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.fitWidth,
                                alignment: Alignment.center)
                          ),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 8.0, top: 110.0),
                           child: Text(name, style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14
                            ),
                            ),
                         ),
                      )
                  ),
                //  SizedBox(height: 2.0)

    ));
  }
}

