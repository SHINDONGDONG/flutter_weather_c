import 'package:flutter/material.dart';
import 'package:flutter_cief_weather/screens/weather_screen.dart';
import '../data/my_location.dart';
import '../data/network.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude;
  double longitude;
  String appidKey = 'bffdb561d5545e3b15c6b429319d20ed';

  @override
  void initState() {
    super.initState();
    getLocation();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: FlutterLogo(),
          onPressed: () {},
        ),
      ),
    );
  }


  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude = myLocation.latitude;
    longitude = myLocation.longitude;


    Network myNetwork = Network(
        lurl1: 'api.openweathermap.org',
        lurl2: '/data/2.5/weather',
        yourId: 'bffdb561d5545e3b15c6b429319d20ed',
        lat: latitude,
        long: longitude,
        aurl1: 'api.openweathermap.org',
        aurl2: '/data/2.5/air_pollution',
        aLat: latitude,
        aLong: longitude,
        aYourId: 'bffdb561d5545e3b15c6b429319d20ed',
    );

    var airDate = await myNetwork.getAriData();
    var weatherData = await myNetwork.getJsonData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(
                  parseWeatherDate: weatherData,
                  parseAirDate: airDate,
                )));
  }
}
