import 'package:flutter/material.dart';

class DogProfile extends StatefulWidget {
  @override
  _DogProfileState createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
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
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
              width: double.maxFinite,
              color: Colors.black,
              child: Image.asset('images/dog1.jpg'),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Louie",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Last Seen on 04/30/2021',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                    'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis orci quam, vehicula vitae metus in, efficitur vulputate ipsum. Ut mauris lectus, malesuada a hendrerit eleifend, vestibulum sed tellus. Integer vestibulum in diam sit amet pharetra.'),
                SizedBox(height: 15.0),
                Text('Last Location: Chinatown, Toronto'),
                SizedBox(height: 30.0),
                Text(
                  'Tags: #dog #lost #toronto #lostdog',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
