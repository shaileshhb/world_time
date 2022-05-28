// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map worldTime = {};

  @override
  Widget build(BuildContext context) {
    worldTime = worldTime.isNotEmpty ? worldTime : ModalRoute.of(context)?.settings.arguments as Map;
    print(worldTime);

    String bgImage = worldTime["isDay"] ? "day.png" : "night.png";
    Color bgColor = worldTime["isDay"] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 128.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    worldTime = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'isDay': result['isDay'],
                    };
                  });
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
                label: const Text(
                  "Edit location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    worldTime["location"],
                    style: const TextStyle(fontSize: 28.0, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                worldTime["time"],
                style: const TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
