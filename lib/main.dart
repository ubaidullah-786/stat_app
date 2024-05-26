import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/screens/initial.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/providers/race_results_provider.dart'; // Import RaceResultsProvider

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
  ),
  fontFamily: 'Rezerv',
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StandingsProvider()),
        ChangeNotifierProvider(create: (_) => RaceResultsProvider()), // Add RaceResultsProvider
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const InitialScreen(),
    );
  }
}
