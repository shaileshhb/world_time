// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  late String time; // time in the specified location
  String flag; // url to asset flag icon
  String pathURL; // location url for api endpoint
  late bool isDay;

  WorldTime(
      {required this.location, required this.flag, required this.pathURL});

  Future<void> getTime() async {
    try {
      var url = Uri.http("worldtimeapi.org", "/api/timezone/$pathURL");
      var response = await http.get(url);
      print(response);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        String dateTime = jsonResponse["datetime"];
        String hourOffset =
            jsonResponse["utc_offset"].toString().substring(1, 3);
        String minuteOffset =
            jsonResponse["utc_offset"].toString().substring(4, 6);

        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(
            hours: int.parse(hourOffset), minutes: int.parse(minuteOffset)));
        // time = now.toString();

        isDay = now.hour > 6 && now.hour < 20 ? true : false;

        time = DateFormat.jm().format(now);
      } else {
        print("Request failed: ${response.statusCode}.");
      }
    } catch (err) {
      print(err);
      time = "err returned";
    }
  }
}
