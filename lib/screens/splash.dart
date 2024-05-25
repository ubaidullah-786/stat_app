import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/screens/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToTabsScreen();
  }

  Future<void> _navigateToTabsScreen() async {
    final standingsProvider =
        Provider.of<StandingsProvider>(context, listen: false);
    await standingsProvider.fetchDriverStandings();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/f1_logo.svg',
              width: 50,
              height: 50,
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 255, 17, 0),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
