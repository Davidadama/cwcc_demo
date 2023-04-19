import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


class Profile extends StatefulWidget {
  late String title;

 // Profile(String s);

  @override
  _ProfileState createState() => _ProfileState();
}


final nameController = TextEditingController();
final emailController = TextEditingController();
final addressController = TextEditingController();
final passController = TextEditingController();
final phoneController = TextEditingController();
final roleController = TextEditingController();  

class _ProfileState extends State<Profile> {



 //Future<FirebaseAuth>  _future = FirebaseAuth.instance.currentUser as Future<FirebaseAuth>;
 
  late String uid, _email, _name, _phone, _address, _role,userDetail, status ;
   String? userID;

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
          .collection('User_information')
          .doc(_user.uid)
          .get().whenComplete(() => userID = _user.uid );
       userID = userInfo as String;
       } catch (e) {
      print("something went wrong");
    }
  }


 /** final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('User_information')
      .snapshots();
**/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body:


      ListView(
          children: <Widget>[
      Padding(
      padding: EdgeInsets.only(left: 15.0, top: 10.0  ),
      child:
      Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.lightBlueAccent,
              onPressed: (){Navigator.of(context).pop();} ),
        ],
      ),
    ),
    SizedBox(height:10.0),
    Padding(
    padding: EdgeInsets.only(top: 15.0, left: 15.0),
    child:
    Text('Profile', style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.lightBlueAccent
    ),
    ),
    ),
    SizedBox(height:78.0),
    Container(
    height: MediaQuery.of(context).size.height - 199.0,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(topRight: Radius.circular(60.0))
    ),
            child:

          StreamBuilder(
                        stream: FirebaseFirestore.instance
              .collection('User_information').where('userId', isEqualTo: userID).snapshots(),
                       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                           if (snapshot.hasError) {
                                  return Center( 
                                        child: Text('Something went wrong'),
                              );
                                     }

        if (snapshot.connectionState == ConnectionState.waiting) {
                           return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.blue,
                                  )
                              );
                 }

                        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

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
                                                            Icon(Icons.person_pin, color: Colors.lightBlueAccent,)
                                                            , Text('Name ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: new Text(data['Name'],
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
                                                            Icon(Icons.email, color: Colors.lightBlueAccent,)
                                                            , Text('email ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['Email'],
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                            ),),

                                                        )
                                                    ),

                                                    SizedBox(height: 10.0),
                                                    ListTile(
                                                        title: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.phone_android, color: Colors.lightBlueAccent,)
                                                            , Text( 'Phone' ,
                                                              style: TextStyle(
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['Phone_number'],
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
                                                            Icon(Icons.person_pin, color: Colors.lightBlueAccent,)
                                                            , Text('Address ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['Address'],
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                            ),),

                                                        )
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ListTile(
                                                        title: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.supervised_user_circle, color: Colors.lightBlueAccent,)
                                                            , Text('Role ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['Role'],
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                            ),),

                                                        )
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    ListTile(
                                                        title: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.calendar_today, color: Colors.lightBlueAccent,)
                                                            , Text('Date ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['Date'],
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                            ),),

                                                        )
                                                    ),
                                                    SizedBox(height:10.0),
                                                   ListTile(
                                                        title: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.perm_identity, color: Colors.lightBlueAccent,)
                                                            , Text('UserID ',
                                                              style: TextStyle(
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w500),
                                                              maxLines: 3,
                                                            )
                                                            ,],
                                                        ),
                                                        subtitle:
                                                        Padding(padding: EdgeInsets.only(left:23.0),
                                                          child: Text(data['userId'],
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                            ),),

                                                        )
                                                    ),


                                                    SizedBox(height:5.0),
                                                 /**
                                                    ElevatedButton(
                                                      onPressed: (){
                                                  updateDialog(context, document);
                                                      },
                                                      child: Text('Update'),
                                                    ), **/
                                                SizedBox(height:1.0),
                                          
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

/**
        Future<dynamic> iD(userID) async{
          FirebaseAuth user = FirebaseAuth.instance;
         ( await user.signInWithEmailAndPassword(email: email, password: _password)).user!.uid;

            setState (() {
      uid = userDetails;
      Text(uid);
      
    });
         return uid;
          
        }
**/
   
/**
  Future _userDetails(userID) async {
    final userDetails = await getData(userID);
    setState (() {
      uid = userDetails;
      Text(uid);
      return uid;
    }

    );
  }


  getData(userID) async{
    DocumentSnapshot result = await FirebaseFirestore.instance.collection('User_information').doc(userID).get();
    return result;
  } **/

   updateDialog(BuildContext context, selectedDoc) async{
    return showDialog(

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
            Row(
                children:<Widget>[
                  Text('Update Data',
                      style: TextStyle(
                          fontSize: 17.0)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: Navigator.of(context).pop,
                    padding: EdgeInsets.only(left: 100.0),
                  ),
                ]
            ),

            content:
            ListView(
                children: <Widget>[
                  Form(
                      key: _formkey,
                      child:
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              maxLength: 20,
                              maxLines: 2,
                              // ignore: missing_return
                              validator: (input){
                                if (input!.isEmpty) {
                                  return 'Please Enter your name';
                                }
                              },
                              onSaved:  (input) {
                                this._name = input!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Stephen Curry',

                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:
                            TextFormField(
                              maxLines: 1,
                              maxLength: 35,
                              validator: (input){
                                if (input!.isEmpty) {
                                  return 'Please enter your email';
                                }
                               },
                              onSaved:  (input) {
                                this._email = input!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'example20@yahoo.com',
                                hintMaxLines: 1,
                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:
                            TextFormField(
                              maxLines: 1,
                              maxLength: 11,
                              validator: (input){
                                if (input!.isEmpty) {
                                  return 'Please enter your email';
                                }
                               },
                              onSaved:  (input) {
                                this._phone = input!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone number',
                                hintText: '07123346578',
                                hintMaxLines: 1,
                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:

                            TextFormField(
                              maxLength: 30,
                              validator: (input){
                                if (input!.isEmpty) {
                                  return 'Please Enter your address';
                                }

                               },
                              onSaved: (input) {
                                this._address= input!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Address',
                                hintText: '24 Apollo crescent',
                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              maxLength: 20,
                              validator: (input){
                                if (input!.isEmpty) {
                                  return 'Please Enter your role';
                                }
                               },
                              onSaved:  (input) {
                                this._role = input!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Role',
                                hintText: 'student',
                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:25.0),
                          ElevatedButton(
                            onPressed: (){
                              if (_formkey.currentState!.validate()) {
                                //no error in validator
                                _formkey.currentState!.save();
                               // showToast();
                                // ignore: unnecessary_statements
                                Navigator.of(context).pop;
                                updateData(selectedDoc, {
                                  "Name": this._name,
                                  "Email": this._email,
                                  "Address": this._address,
                                  "Phone_number": this._phone,
                                  "Role": this._role,
                                }
                                );
                              }
                              else{
                                //validation error
                                setState(() {
                                  var _validate = true;
                                });
                              }

                            },
                            child: Text('Update'),

                          )
                        ],
                      )
                  )

                ]
            ),
          );
        }
    );
  }

   /**  updateDialog1(BuildContext context, selectedDoc) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
            Row(
                children:<Widget>[
                  Text('Answer the question',
                      style: TextStyle(
                          fontSize: 17.0)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: Navigator.of(context).pop,
                    padding: EdgeInsets.only(left: 100.0),
                  ),
                ]
            ),

            content:
            ListView(
                children: <Widget>[
                  Form(
                      key: _formkey,
                      child:
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                            child:
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              maxLength: 20,
                              maxLines: 2,
                              // ignore: missing_return
                              validator: (input){
                                if (input.isEmpty) {
                                  return 'Please Enter your answer';
                                }
                              },
                              onSaved:  (input) {
                                this._answer = input;
                              },
                              decoration: InputDecoration(
                                labelText: 'Answer',
                                hintText: 'Stephen Curry',

                                labelStyle: TextStyle(
                                    fontSize: 17.0,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:25.0),
                          ElevatedButton(
                            onPressed: (){
                              if (_formkey.currentState.validate()) {
                                //no error in validator
                                _formkey.currentState.save();
                                // showToast();
                                Navigator.of(context).pop;
                                updateData1(selectedDoc,{
                                  'Answer': this._answer
                                });
                              }
                              else{
                                //validation error
                                setState(() {
                                  var _validate = true;
                                });
                              }

                            },
                            child: Text('Answer'),

                          )
                        ],
                      )
                  )

                ]
            ),
          );
        }
    );
  }
**/

}
void showToast() {
  Fluttertoast.showToast(
      msg: 'Document updated',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    //  timeInSecForIos: 2,
      backgroundColor: Colors.blue,
      textColor: Colors.white
  );
}
/**
updateData(selectedDoc, newValues) {
  FirebaseFirestore.instance.collection('User_information')
      .doc(selectedDoc)
      .update(newValues).whenComplete(() => showToast())
      .catchError((e) {
    print(e);
  }
  );
} **/

CollectionReference users = FirebaseFirestore.instance.collection('User_information');

Future<void> updateData(selectedDoc, newValues) {
  return users
      .doc(selectedDoc)
      .update(newValues)
      .then((value) => showToast())
      .catchError((e) => print(e));
}

/** updateData1(selectedDoc,newValues) {
  FirebaseFirestore.instance.collection('User_information')
      .doc(selectedDoc)
      .set(newValues,)
      .catchError((e) {
    print(e);
  }
  );
  showToast();

}
**/
