import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> data; // Declare data with explicit type
  @override
  Widget build(BuildContext context) {
    // receiving actual argument of Map data
    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(data);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
      child: SafeArea(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/location');
              },
              icon: const Icon(Icons.edit_location),
              label: const Text('Edit Location'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data['location'],
                  style: const TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            // output the time
            Text(
              data['time'],
              style: const TextStyle(
                fontSize: 66.0,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
