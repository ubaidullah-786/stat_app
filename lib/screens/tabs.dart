import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_app/providers/standing_provider.dart';
import 'package:stats_app/screens/constructor_standings.dart';
import 'package:stats_app/screens/driver_standings.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 71, 70, 70),
        appBar: AppBar(
          title: const Text('STANDINGS'),
          backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
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
          ),
        ),
        body: Consumer<StandingsProvider>(
          builder: (context, standingsProvider, child) {
            return TabBarView(
              controller: _tabController,
              children: const [
                DriverStandingsScreen(),
                ConstructorStandingsScreen(),
              ],
            );
          },
        ),
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
            onTap: (index) {
              _tabController.animateTo(index);
            },
            currentIndex: _tabController.index,
            selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                label: 'Standings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                label: 'Race results',
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
