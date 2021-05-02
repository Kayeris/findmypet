import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class DogProfile extends StatefulWidget {
  String id = '1';
  DogProfile(this.id);

  @override
  _DogProfileState createState() => _DogProfileState(id);
}

class _DogProfileState extends State<DogProfile> {
  _DogProfileState(this.postId);
  final String postId;
  final getUrl =
      'https://us-central1-findmypet-312403.cloudfunctions.net/api/ViewPost?id=1';
  var jsonString;
  Map<String, dynamic> post;
  Future<String> data;

  Future<String> _jsonFromUrl() async {
    final response = await http.get(Uri.parse(getUrl));
    var string = response.body;
    post = jsonDecode(string);

    return string;
  }

  @override
  void initState() {
    _jsonFromUrl();
    super.initState();
    //_jsonFromUrl();
    print('data');
    data = _jsonFromUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'DOG PROFILE',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 17.0,
                onPressed: () => Navigator.pop(context));
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box),
            color: Colors.black,
            iconSize: 17.0,
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Container(
                  child: Container(
                    height: (MediaQuery.of(context).size.height - 75.0) / 2,
                    width: double.maxFinite,
                    color: Colors.black,
                    child: Image.asset('images/dog1.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['petName'],
                        //'data',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Description: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: post['description']),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Last Location: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: post['location'],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Contact Info: \n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            WidgetSpan(child: Icon(Icons.person)),
                            TextSpan(
                              text: '\t' + post['ownerName'] + '\n',
                            ),
                            WidgetSpan(child: Icon(Icons.phone_android)),
                            TextSpan(
                              text: '\t' + post['ownerPN'] + '\n',
                            ),
                            WidgetSpan(child: Icon(Icons.email)),
                            TextSpan(text: '\t' + post['ownerEmail'])
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Tags: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '#dog #lost #toronto #lostdog',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
