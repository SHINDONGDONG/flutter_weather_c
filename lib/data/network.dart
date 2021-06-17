import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final lurl1;
  final lurl2;
  final aurl1;
  final aurl2;
  final location;
  final aLat;
  final lat;
  final aLong;
  final long;
  final yourId;
  final aYourId;

  Network({this.lurl1, this.lurl2, this.aurl1,this.lat,this.long, this.yourId,this.location,this.aurl2, this.aLat, this.aLong, this.aYourId, });

  Future<dynamic> getAriData() async {
    var aUri = Uri.https(aurl1, aurl2,
        {'lat' : lat.toString(),'lon':long.toString(), 'appid': yourId,});
    http.Response aResponse = await http.get(aUri);

    if (aResponse.statusCode == 200) {
      String airData = aResponse.body;
      var aParsingData = jsonDecode(airData);
      return aParsingData;
    }
  }

  Future<dynamic> getJsonData() async {
      //uri 에서 더블타입은 toString으로 바꾸어주어야 된다!!!!!!!!!!!!!!!!!
      var uri = Uri.https(lurl1, lurl2,
          {'lat' : lat.toString(),'lon':long.toString(), 'appid': yourId,'units':'metric'});
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        String jsonData = response.body;
        var parsingData = jsonDecode(jsonData);
        return parsingData;
      }

      // void fetchData() async {
      //   // var uri = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=london&appid=bffdb561d5545e3b15c6b429319d20ed');
      //
      //   var uri = Uri.https('api.openweathermap.org', '/data/2.5/weather',
      //       {'q': 'london', 'appid': 'bffdb561d5545e3b15c6b429319d20ed'});
      //   http.Response response = await http.get(uri);
      //   if (response.statusCode == 200) {
      //     String jsonData = response.body;
      //     var myJson = jsonDecode(jsonData)['weather'][0]['description'];
      //     print(myJson);
      //
      //     var mySpeed = jsonDecode(jsonData)['wind']['speed'];
      //     print(mySpeed);
      //
      //     var myId = jsonDecode(jsonData)['id'];
      //     print(myId);
      //   } else {
      //     print(response.statusCode);
      //   }
      // }


    }
}