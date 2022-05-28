// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(pathURL: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(pathURL: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(pathURL: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(pathURL: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(pathURL: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(pathURL: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  
  void updateTime(index) async {
    await locations[index].getTime();
    Navigator.pop(context, {
      'location': locations[index].location,
      'flag': locations[index].flag,
      'time': locations[index].time,
      'isDay': locations[index].isDay,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 236, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(108, 189, 255, 1),
        title: const Text("Choose Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                tileColor: const Color.fromRGBO(223, 243, 255, 1),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/flags/${locations[index].flag}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
