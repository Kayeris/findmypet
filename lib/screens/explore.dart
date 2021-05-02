import 'package:findmypet/bloc/api.dart';
import 'package:findmypet/bloc/profile_model.dart';
import 'package:findmypet/screens/dogprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

/* Credits to: rajayogan for design and idea for cards: 
https://github.com/rajayogan/flutterui-minimaldesigns/blob/master/lib/main.dart

Modified by Jack Hoang
*/

class ExploreScreen extends StatefulWidget {
  User user;
  ExploreScreen(this.user);
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final API api = Get.put(API());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('James Smith'),
                decoration: BoxDecoration(color: Color(0xFF91BDF3)),
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Discover'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Sign Out'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'EXPLORE',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              iconSize: 17.0,
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
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
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Container(
          child: GetBuilder(
              initState: (_) {
                Get.find<API>().search();
              },
              builder: (API bloc) => bloc.searchList.isEmpty
                  ? Container()
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 60),
                          child: CustomScrollView(
                            slivers: [
                              SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  //TODO ADJUST WIDTH ? I MESSED UP

                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width / 2,
                                  //TODO ADJUST HEIGHT? I MESSED UP

                                  mainAxisSpacing: 0,
                                  childAspectRatio: 0.7,
                                ),
                                delegate:
                                    SliverChildBuilderDelegate((context, i) {
                                  return row(bloc.searchList[i]);
                                }, childCount: (bloc.searchList.length).ceil()),
                              )
                            ],
                          ),
                        ),
                        buildFloatingSearchBar(),
                      ],
                    ))),
    );
  }

  // Search bar widget
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      borderRadius: BorderRadius.circular(12),
      //title: Container(),
      height: 38,
      leadingActions: [Container()],
      margins: const EdgeInsets.only(top: 1, left: 15, right: 15),
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      automaticallyImplyDrawerHamburger: false,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 70, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Row widget for each card
  Widget row(ProfileModel model) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Container(
            height: 250.0,
            width: (MediaQuery.of(context).size.width - 100) / 2,
            child: Column(
              // Cross Axis Align by default is .centre. Do .start to align text to left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: InkWell(
                    child: Container(
                      height: 125.0,
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(model.image),
                              fit: BoxFit.cover)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DogProfile(model.id)));
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  model.petName,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  model.creationTime.toString(),
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 10),

                ///TODO FUNCTION TO TURN LIST INTO HASHTAGS

                model.hashtags.length == 0
                    ? Container()
                    : Text(
                        model.hashtags,
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
