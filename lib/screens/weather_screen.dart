import 'package:flutter/material.dart';
import 'package:flutter_cief_weather/models/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherDate;
  final dynamic parseAirDate;

  WeatherScreen({@required this.parseWeatherDate,@required this.parseAirDate});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temp;
  var cityName;
  var date = DateTime.now();
  var condition;
  Model model = Model();
  Widget icon;
  String description;
  Widget airiIcon;
  Widget airState;
  double dust1;
  double dust2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.parseAirDate);
    updateDate(widget.parseWeatherDate,widget.parseAirDate);
  }

  void updateDate(dynamic weatherData, dynamic airData) {
    temp = weatherData['main']['temp'];
    cityName = weatherData['name'];
    int index = airData['list'][0]['main']['aqi'];
    condition = weatherData['weather'][0]['id'];
    description = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition);
    airiIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];

  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('h:mm:ss a').format(now);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //바디를 앱바디로 확장시킨다는것
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cityName,
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            TimerBuilder.periodic((Duration(milliseconds: 1000)),
                                builder: (context) {
                              print('${getSystemTime()}');
                              return Text(
                                getSystemTime(),
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: Colors.white),
                              );
                            }),
                            Text(
                              DateFormat(" - EEEE").format(date),
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              //MMM이 세개면 영어로나타남
                              DateFormat(" - d MMM yyyy").format(date),
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${temp.toStringAsFixed(1)}\u2103',
                        style:
                            GoogleFonts.lato(fontSize: 85, color: Colors.white),
                      ),
                      Row(
                        children: [
                          icon,
                          // SvgPicture.asset('assets/svg/climacon-sun.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(description,
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'AQI(대기질지수)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white),
                                ),
                                // Image.asset("assets/image/bad.png",width: 37,height: 35,),
                                airiIcon,
                                airState,
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  '$dust1',
                                  style: GoogleFonts.lato(
                                      fontSize: 20, color: Colors.white),
                                ),

                                Text(
                                  'm/3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  '$dust2',
                                  style: GoogleFonts.lato(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'm/3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
