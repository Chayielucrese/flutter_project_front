import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class RequestFormController extends AppController {
  final pickupPointController = TextEditingController();
  final destinationController = TextEditingController();
    final dateController = TextEditingController();
      final timeController = TextEditingController();
late final GooglePlaceAutoCompleteTextField googlePlace;



  @override
  void onInit() {
    super.onInit();
    String API_KEY ='AIzaSyCrwl_MN7W773beWLynfk7pPGNaKrepdzE';
     }

     
}
