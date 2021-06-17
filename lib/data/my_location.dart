import 'package:geolocator/geolocator.dart';


class MyLocation{
  double longitude;
  double latitude;

  Future<void> getMyCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print('위도 : $latitude\n경도 : $longitude');
    } catch (e) {
      print(e + ' 문제가 발생');
    }

}



}