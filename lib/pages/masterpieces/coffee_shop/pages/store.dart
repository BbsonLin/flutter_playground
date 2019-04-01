import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';

class StorePage extends StatefulWidget {
  @override
  StorePageState createState() {
    return new StorePageState();
  }
}

class StorePageState extends State<StorePage> {
  GoogleMapController mapController;

//  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: Container(
//        child: Text(currentLocation.toString()),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(25.071427, 121.367754),
            zoom: 15,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      mapController.addMarker(
        MarkerOptions(
          draggable: false,
          position: LatLng(
            25.0694622,
            121.3630223,
          ),
          infoWindowText: InfoWindowText("Coffee Shop", "金鑛咖啡"),
        ),
      );
    });
  }

//  _getCurrentPos() async {
//    try {
//      var location = new Location();
//      currentLocation = await location.getLocation();
//    } on PlatformException {
//      currentLocation = null;
//    }
//  }
}
