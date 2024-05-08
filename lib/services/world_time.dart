import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url for an assets flat icon
  String url; // location url for the API endpoint

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    //  make the request
    try {
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);
      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      print('DateTime: $dateTime');
      print('offset: $offset');

      // create a dateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      print('Now Edited Time is: $now');

      // formate time
      time = DateFormat.jm()
          .format(now); // DateFormate function provide by intl package
    } catch (error) {
      print('Error fetching data: $error');
      time = "Could not get time data ";
    }
  }
}
