import 'dart:convert';

/// Flutter code sample for Form
// This example shows a [Form] with one [TextFormField] to enter an email
// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  Future<http.Response> createPost(
      String description,
      String id,
      String image,
      String location,
      String ownerEmail,
      String ownerName,
      String ownerPN,
      String petName,
      String userId,
      String hashtags) {
    print(id);
    return http.post(
      Uri.https(
          'us-central1-findmypet-312403.cloudfunctions.net', 'api/inputForm'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'description': description,
        'id': id,
        'image': image,
        'location': location,
        'ownerEmail': ownerEmail,
        'ownerName': ownerName,
        'ownerPN': ownerPN,
        'petName': petName,
        'userId': userId,
        'hashtags': hashtags,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xFFFB9D88),
          appBar: AppBar(
            title: Text("File A Report"),
            centerTitle: true,
            backgroundColor: const Color(0xFFF97D62),
            foregroundColor: const Color(0xFFF5F5F5),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Name of Pet",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                          color: Colors.grey[800], fontStyle: FontStyle.italic),
                      hintText: "Ex. Mr.Snowbell",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Image of Pet",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Text('UPLOAD'),
                    onPressed: () {
                      print('Pressed');
                    },
                  )),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Short Description of Pet",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 250,
                  maxLines: null,
                  minLines: 4,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintText: "Type Here...",
                      hintStyle: new TextStyle(
                        color: Colors.grey[800],
                        fontStyle: FontStyle.italic,
                      ),
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Last Seen Location",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                          color: Colors.grey[800], fontStyle: FontStyle.italic),
                      hintText: "Ex. Missisauga, XX Street",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Owner's Name",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                          color: Colors.grey[800], fontStyle: FontStyle.italic),
                      hintText: "Ex. John Smith",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Owner's Contact Information",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                          color: Colors.grey[800], fontStyle: FontStyle.italic),
                      hintText: "Phone Number",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                          color: Colors.grey[800], fontStyle: FontStyle.italic),
                      hintText: "Email Address",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Text(
                  "Tags",
                  style:
                      TextStyle(fontSize: 20, color: const Color(0xFFF5F5F5)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 100,
                  maxLines: null,
                  minLines: 3,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.grey[800],
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: "Ex. #goldenretriever",
                      fillColor: const Color(0xFFF6E8EA)),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Text('SUBMIT'),
                    onPressed: () async {
                      print('Pressed');
                      await createPost(
                          'Lost him on 12/12/20',
                          '10',
                          'image',
                          'Mississauga',
                          'jack_hoang@hotmail.com',
                          'Jack Hoang',
                          '4168273245',
                          'Charlie',
                          'jack_hoang@hotmail.com',
                          '#dog');
                    },
                  )),
            ],
          )),
    );
  }
}
