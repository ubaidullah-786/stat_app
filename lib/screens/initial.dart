import 'package:flutter/material.dart';
import 'package:stats_app/screens/tabs.dart';
import 'package:stats_app/screens/splash.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await fetchDriverStandings(); // Call the actual data fetching function
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const SplashScreen() : const TabsScreen();
  }
}

Future<void> fetchDriverStandings() async {
  await Future.delayed(
    const Duration(seconds: 5),
  );
}
