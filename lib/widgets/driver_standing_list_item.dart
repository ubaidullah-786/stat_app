import 'package:flutter/material.dart';
import 'package:stats_app/models/driver_standings_model.dart';
import 'package:stats_app/screens/driver_details.dart'; // Import the FixtureItem screen

class DriverStandingListItem extends StatelessWidget {
  final DriverStanding driverStanding;

  const DriverStandingListItem({required this.driverStanding, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      title: Row(
        children: [
          Text(
            driverStanding.position,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              driverStanding.driverName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Text(
        '${driverStanding.points} PTS',
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.orange,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DriverDetails(
              position: driverStanding.position,
              driverName: driverStanding.driverName,
              constructorName: driverStanding.constructorName,
              points: driverStanding.points,
              wikipedia: driverStanding.wikipedia,
            ),
          ),
        );
      },
    );
  }
}
