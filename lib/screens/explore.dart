import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

/* Credits to: rajayogan for design and idea: 
https://github.com/rajayogan/flutterui-minimaldesigns/blob/master/lib/main.dart 

Modified by Jack Hoang
*/

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          iconSize: 17.0,
          onPressed: () {},
        ),
      ),
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: 25.0,
          ),
          row('images/dog1.jpg', 'images/dog2.jpg'),
          buildFloatingSearchBar()
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      borderRadius: BorderRadius.circular(12),
      height: 38,
      margins: const EdgeInsets.only(top: 1, left: 15, right: 15),
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
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

  Widget row(String imgPath1, String imgPath2) {
    return Container(
      height: 125.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          Container(
            height: 125.0,
            width: (MediaQuery.of(context).size.width - 100.0) / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage(imgPath1), fit: BoxFit.cover)),
          ),
          Container(
            height: 125.0,
            width: (MediaQuery.of(context).size.width - 100.0) / 2,
            child: Column(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 125.0,
                  width: (MediaQuery.of(context).size.width - 30 / 2),
                  child: Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage(imgPath2), fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
