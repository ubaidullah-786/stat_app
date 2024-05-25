import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:stats_app/models/driver_standings_model.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/widgets/driver_standing_list_item.dart';

class DriverStandingsScreen extends StatelessWidget {
  const DriverStandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StandingsProvider>(
      builder: (context, standingsProvider, child) {
        final driverStandings = standingsProvider.driverStandings;
        final isLoading = standingsProvider.isLoading;

        return Scaffold(
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: driverStandings.length,
                  itemBuilder: (context, index) {
                    final driverStanding = driverStandings[index];
                    return DriverStandingListItem(driverStanding: driverStanding);
                  },
                ),
        );
      },
    );
  }
}