import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url for an assets flat icon
  String url; // location url for the API endpoint
  bool isDayTime = true; // true or false for day time

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // Check for network connectivity
    bool isConnected = await http.Client()
        .get(Uri.parse('https://google.com'))
        .then((response) => true)
        .catchError((error) => false);

    if (!isConnected) {
      time = "No internet connection";
      return;
    }

    // Make the request
    try {
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];

      // create a DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.toUtc(); // Convert datetime to UTC
      now = now.add(Duration(
          hours: int.parse(offset.split(':')[0]),
          minutes: int.parse(offset.split(':')[1]))); // Add the offset directly

      // format time
      isDayTime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm()
          .format(now); // Use DateFormat from intl package to format time
    } catch (error) {
      // Handle other errors
      time = "Could not get time data";
    }
  }
}
