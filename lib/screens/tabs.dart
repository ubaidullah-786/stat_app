import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/providers/race_results_provider.dart';
import 'package:stats_app/providers/schedule_provider.dart';
import 'package:stats_app/screens/constructor_standings.dart';
import 'package:stats_app/screens/driver_standings.dart';
import 'package:stats_app/screens/race_results.dart';
import 'package:stats_app/screens/schedule.dart';
import 'package:stats_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Provider.of<ScheduleProvider>(context, listen: false).fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 71, 70, 70),
        appBar: AppBar(
          title: Consumer<RaceResultsProvider>(
            builder: (context, raceResultsProvider, child) {
              return Text(
                _selectedIndex == 0
                    ? 'STANDINGS'
                    : _selectedIndex == 1
                        ? raceResultsProvider.eventName
                        : 'SCHEDULE',
                style: const TextStyle(
                  fontFamily: 'RezervBold',
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: _selectedIndex == 0
              ? TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(
                    fontFamily: 'RezervBold',
                  ),
                  unselectedLabelStyle: const TextStyle(fontFamily: 'Rezerv'),
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 6.0, color: Colors.white),
                    insets: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                  tabs: const [
                    Tab(text: 'Drivers'),
                    Tab(text: 'Constructors'),
                  ],
                )
              : null,
        ),
        drawer: MainDrawer(onSelectScreen: _onTabTapped), // Add Drawer here
        body: _selectedIndex == 0
            ? Consumer<StandingsProvider>(
                builder: (context, standingsProvider, child) {
                  return TabBarView(
                    controller: _tabController,
                    children: const [
                      DriverStandingsScreen(),
                      ConstructorStandingsScreen(),
                    ],
                  );
                },
              )
            : _selectedIndex == 1
                ? Consumer<RaceResultsProvider>(
                    builder: (context, raceResultsProvider, child) {
                      return const RaceResultsScreen();
                    },
                  )
                : const ScheduleScreen(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            onTap: _onTabTapped,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                label: 'Standings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                label: 'Weekly results',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Schedule',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
