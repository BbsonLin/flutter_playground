import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/pages/masterpieces/coffee_shop/app.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketioThing extends StatefulWidget {
  @override
  _SocketioThingState createState() => _SocketioThingState();
}

class _SocketioThingState extends State<SocketioThing> {
  IO.Socket socketIO;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  @override
  void dispose() {
    if (socketIO.connected) {
      socketIO.disconnect();
    }
    socketIO.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Distroy Socketio"),
            onPressed: () {
              socketIO.destroy();
            },
          ),
        ),
      ),
    );
  }

  initSocket() async {
    IO.Socket socketIO = IO.io(
      "http://localhost:5001/test",
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
        "namespace": "/test",
      },
    );
    socketIO.on('connect', (_) {
      print('connect');
    });

    socketIO.on('device-status', (data) => print(data));

    socketIO.on('coffee-app', (data) {
      runApp(CoffeeShopApp());
    });

    socketIO.on('main-app', (data) {
      runApp(MainApp());
    });

    socketIO.open();
    // socketIO = SocketIOManager().createSocketIO(
    //   "http://192.168.1.139:5001",
    //   "/test"
    // );
    // socketIO.init();

    // socketIO.subscribe("connect", (data) {
    //   print("connected");
    // });

    // socketIO.subscribe("device-status", (data) {
    //   print(data);
    // });
  }
}
