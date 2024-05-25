import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/widgets/constructor_standing_list_item.dart';

class ConstructorStandingsScreen extends StatelessWidget {
  const ConstructorStandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standingsProvider = Provider.of<StandingsProvider>(context);

    return standingsProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: standingsProvider.constructorStandings.length,
            itemBuilder: (context, index) {
              final constructorStanding = standingsProvider.constructorStandings[index];
              return ConstructorStandingListItem(constructorStanding: constructorStanding);
            },
          );
  }
}