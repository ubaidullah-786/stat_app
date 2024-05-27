import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/screens/initial.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/providers/race_results_provider.dart';// Import RaceResultsProvider
import 'package:stats_app/providers/schedule_provider.dart';// Import RaceResultsProvider

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 239, 3, 2),
  ),
  fontFamily: 'Rezerv',
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StandingsProvider()),
        ChangeNotifierProvider(create: (_) => RaceResultsProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
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
