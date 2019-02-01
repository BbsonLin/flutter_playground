import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class _Stuff {
  final String text;

  _Stuff({this.text});
}

List<_Stuff> _pages = [
  _Stuff(text: "Only Column"),
  _Stuff(text: "Only Row"),
  _Stuff(text: "Column Wrap Rows"),
];

class LayoutStuff extends StatefulWidget {
  @override
  LayoutStuffState createState() {
    return new LayoutStuffState();
  }
}

class LayoutStuffState extends State<LayoutStuff>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layout Stuff"),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _pages.map<Tab>((_Stuff stuff) {
            return Tab(text: stuff.text);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          onlyColumn(),
          onlyRow(),
          columnWrapRows(),
        ],
      ),
    );
  }

  onlyColumn() {
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(children: [
            TextSpan(text: "範例取自", style: TextStyle(color: Colors.black)),
            TextSpan(
              text: "docs.flutter.io - Column Class",
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  var url =
                      "https://docs.flutter.io/flutter/widgets/Column-class.html";
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
            )
          ]),
        ),
        Text('Craft beautiful UIs'),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, // otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
      ],
    );
  }

  onlyRow() {
    return Row(
      children: <Widget>[
        FlutterLogo(),
        Expanded(
          child: Text(
              'Flutter\'s hot reload helps you quickly and easily experiment, '
              'build UIs, add features, and fix bug faster. Experience sub-second reload times,'
              ' without losing state, on emulators, simulators, and hardware for iOS and Android.'),
        ),
        Icon(Icons.sentiment_very_satisfied),
      ],
    );
  }

  columnWrapRows() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
