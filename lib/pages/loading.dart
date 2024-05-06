import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getTime() async {
    //  make the request
    try {
      http.Response response = await http.get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Europe/London'));
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
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('loading screen'),
    );
  }
}
