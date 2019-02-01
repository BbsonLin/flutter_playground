import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/toys/layout_stuff.dart';

class ToysPage extends StatefulWidget {
  @override
  ToysPageState createState() {
    return new ToysPageState();
  }
}

class ToysPageState extends State<ToysPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toys"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Layout Stuff"),
                    onTap: () {
                      print(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          print(context);
                          return LayoutStuff();
                        }),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
