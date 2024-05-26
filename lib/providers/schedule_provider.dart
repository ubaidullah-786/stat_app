import 'package:flutter/material.dart';
import 'package:stats_app/models/race.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ScheduleProvider with ChangeNotifier {
  List<Race> _races = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<Race> get races => _races;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchData() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      var url = Uri.https('ergast.com', '/api/f1/current.json', {'q': '{http}'});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        var raceList = jsonResponse["MRData"]["RaceTable"]["Races"].toList();
        _races = _parseRaces(raceList);
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Race> _parseRaces(List<dynamic> data) {
    final List<Race> races = <Race>[];
    final DateTime today = DateTime.now();

    for (var i = 0; i < data.length; i++) {
      final year = data[i]["date"].split("-")[0];
      final month = data[i]["date"].split("-")[1];
      final day = data[i]["date"].split("-")[2];
      final time = data[i]["time"].split(":")[0];

      final DateTime date = DateTime.utc(int.parse(year), int.parse(month),
              int.parse(day), int.parse(time))
          .toLocal();

      final color = (date.day == today.day &&
              date.month == today.month &&
              date.year == today.year)
          ? Colors.green
          : date.isBefore(today)
              ? Colors.grey
              : Colors.blue;

      races.add(Race(data[i]["raceName"], date, date, color, false,
          data[i]["Circuit"]["Location"]["locality"], data[i]["url"]));
    }

    return races;
  }
}
