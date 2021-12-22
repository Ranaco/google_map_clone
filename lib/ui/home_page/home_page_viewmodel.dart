import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_map_clone/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:stacked/stacked.dart';
import 'package:geolocator/geolocator.dart';

class HomePageViewModel extends BaseViewModel {
  GoogleMapController? googleMapController;
  MapType mapType = MapType.normal;
  Directions? directions;
  Completer<GoogleMapController> completer = Completer();
  Position? currentPosition;
  var initLocation = const CameraPosition(
      target:  LatLng(25.62736295070256, 85.06401522682283), zoom: 39.15);

  initMap() async {
  }
  String? place;

  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  verifyPlace(GlobalKey<FormState> key){
    if(key.currentState!.validate()){

    }
  }
//----------------------------------------------------------------------------------//
   Marker? initMarker;
//----------------------------------------------------------------------------------//
   Marker? secondMarker;
//----------------------------------------------------------------------------------//
  final Marker firstMarker = const Marker(
    markerId: MarkerId("firstMarker"),
    icon: BitmapDescriptor.defaultMarker,
    infoWindow: InfoWindow(
      title: "Start",
    ),
  );
//----------------------------------------------------------------------------------//
  void changeMapType(int value) {
    switch (value) {
      case 0:
        {
          mapType = MapType.satellite;
          notifyListeners();
          break;
        }
      case 1:
        {
          mapType = MapType.normal;
          notifyListeners();
          break;
        }
      case 2:
        {
          mapType = MapType.terrain;
          notifyListeners();
          break;
        }
      case 3:
        {
          mapType = MapType.hybrid;
          notifyListeners();
          break;
        }
    }
  }
  //--------------------------------------------------------------------------------//
}
