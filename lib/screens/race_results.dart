import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/race_results_provider.dart';
import 'package:stats_app/screens/race_result_details.dart'; // Import the RaceResultDetails screen
import 'package:stats_app/widgets/race_result_list_item.dart';

class RaceResultsScreen extends StatelessWidget {
  const RaceResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RaceResultsProvider>(
      builder: (context, raceResultsProvider, child) {
        final raceResults = raceResultsProvider.raceResults;
        final isLoading = raceResultsProvider.isLoading;

        return Scaffold(
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: raceResults.length,
                  itemBuilder: (context, index) {
                    final raceResult = raceResults[index];
                    return RaceResultListItem(
                      raceResult: raceResult,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RaceResultDetails(
                              raceResult: raceResult,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}