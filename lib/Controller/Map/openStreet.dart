import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Openstreet extends StatelessWidget {
  const Openstreet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body:OpenStreetMapSearchAndPick(
        center: LatLong(3.8480, 11.5021),
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: (pickedData) {
        }) ,
    );
  }
  
}
