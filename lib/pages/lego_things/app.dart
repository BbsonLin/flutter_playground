import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/lego_things/now_time.dart';
import 'package:flutter_playground/pages/lego_things/pin_pad.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LegoThingsExample extends StatefulWidget {
  @override
  LegoThingsExampleState createState() {
    return new LegoThingsExampleState();
  }
}

class LegoThingsExampleState extends State<LegoThingsExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _buildScaffold(context),
      theme: ThemeData(
       primaryColor: Colors.blue
      ),
    );
  }

  Widget _buildScaffold(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lego Things"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.clock),
            title: Text("Now Time"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NowTimeExample();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.dialpad),
            title: Text("Pin pad"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PinPadExample();
              }));
            },
          )
        ],
      ),
    );
  }
}
