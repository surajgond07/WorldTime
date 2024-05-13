import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> data = {}; // Declare data with explicit type

  // To lock the HomeScreen to portrait mode only
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Receiving actual argument of Map data
    data = (data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)!;

    // Check if data is null or empty
    if (data == null || data!.isEmpty) {
      // Set default location to Kolkata
      data = {
        'location': 'Kolkata',
        'time': '', // set a default time if needed
        'isDayTime': true, // set a default day/night state if needed
        'flag': 'india.png' // set a default flag if needed
      };

      // Optionally, fetch time data for Kolkata here
      // and update the 'time' property in the 'data' map asynchronously.
    }

    // Extract data
    String location = data!['location'] ?? 'Unknown Location';
    String time = data!['time'] ?? 'Unknown Time';
    bool isDayTime = data!['isDayTime'] ?? true;

    // Set background
    String bgImage = isDayTime ? 'day.png' : 'night.png';
    Color? bgColor = isDayTime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 94, 93, 93)
                        .withOpacity(0.5), // Highlighted color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        if (result != null && result is Map<String, dynamic>) {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDayTime': result['isDayTime'],
                            'flag': result['flag']
                          };
                        }
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Change Location',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 35.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Output the time
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Output the time
                const Text(
                  'Developed by - Suraj Gond',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
