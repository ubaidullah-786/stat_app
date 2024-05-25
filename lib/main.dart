import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stats_app/screens/initial.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/standing_provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StandingsProvider(),
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
