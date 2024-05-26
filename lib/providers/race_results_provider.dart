import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stats_app/models/race_result_model.dart'; // Import the RaceResultModel

class RaceResultsProvider extends ChangeNotifier {
  List<RaceResult> _raceResults = [];
  List<RaceResult> get raceResults => _raceResults;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  RaceResultsProvider() {
    fetchRaceResults();
  }

  Future<void> fetchRaceResults() async {
    final url = Uri.https('ergast.com', 'api/f1/current/last/results.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final resultsList =
          data['MRData']['RaceTable']['Races'][0]['Results'] as List;
      final raceName =
          data['MRData']['RaceTable']['Races'][0]['raceName'] as String;
      _raceResults = resultsList
          .map((json) => RaceResult.fromJson({
                ...json,
                'raceName': raceName,
              }))
          .toList();
      _isLoading = false;
      notifyListeners();
    }
  }
}
