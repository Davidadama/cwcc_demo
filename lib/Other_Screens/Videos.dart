import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_test/flutter_test.dart';


class webView extends StatefulWidget {
  //final String title;
  //const events(String s,  {required Key key, required this.title}) : super(key: key);

  @override
  _webViewState createState() => _webViewState();
}


class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('webview',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://desiod.com/',
        javascriptMode: JavascriptMode.unrestricted,
      )

    );
  }
}



