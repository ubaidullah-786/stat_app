import 'package:flutter/material.dart';
import 'package:stats_app/models/constructor_standing_model.dart';
import 'package:stats_app/models/driver_standings_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StandingsProvider extends ChangeNotifier {
  List<DriverStanding> _driverStandings = [];
  List<DriverStanding> get driverStandings => _driverStandings;

  List<ConstructorStanding> _constructorStandings = [];
  List<ConstructorStanding> get constructorStandings => _constructorStandings;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  StandingsProvider() {
    fetchDriverStandings();
    fetchConstructorStandings();
  }

  Future<void> fetchDriverStandings() async {
    final url = Uri.https('ergast.com', '/api/f1/current/driverStandings.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final standingsList = data['MRData']['StandingsTable']['StandingsLists']
          [0]['DriverStandings'] as List;
      _driverStandings =
          standingsList.map((json) => DriverStanding.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> fetchConstructorStandings() async {
    final url =
        Uri.https('ergast.com', '/api/f1/current/constructorStandings.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final standingsList = data['MRData']['StandingsTable']['StandingsLists']
          [0]['ConstructorStandings'] as List;
      _constructorStandings = standingsList
          .map((json) => ConstructorStanding.fromJson(json))
          .toList();
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
