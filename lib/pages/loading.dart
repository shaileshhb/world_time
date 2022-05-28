// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "Loading...";

  void setWorldTime() async {
    WorldTime worldTime = WorldTime(
        location: "Kolkata",
        flag: "assets/images/clock.png",
        pathURL: "Asia/Kolkata");

    await worldTime.getTime();
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDay': worldTime.isDay,
    });
    // print(worldTime.time);
    // setState(() {
    //   time = worldTime.time;
    // });
  }

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.blueGrey,
          size: 60.0,
        ),
      ),
    );
  }
}
