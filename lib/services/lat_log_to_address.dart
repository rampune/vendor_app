import 'dart:async';

import 'package:geocoding/geocoding.dart';

Future<String?> getAddressFromLatLng(double lat, double lng,
{int timeOutSecond=10}
    ) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng).timeout(Duration(
      seconds: timeOutSecond,
    ),onTimeout: (){
      throw TimeoutException("Location request timed out");
    });

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      print(" Address: $address");
      return address;
    } else {
      print("No address found.");
      return "No Address found";
    }
  } catch (e) {
    print("Error: $e");
    return null;

  }
}
