// screens/constructor_details_screen.dart
import 'package:flutter/material.dart';
import 'package:stats_app/models/constructor_standing_model.dart';

class ConstructorDetails extends StatelessWidget {
  final ConstructorStanding constructorStanding;

  const ConstructorDetails({required this.constructorStanding, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(constructorStanding.constructorName),
        backgroundColor:
            const Color.fromARGB(255, 255, 17, 0), // Adjust color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                constructorStanding.constructorName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Position: ${constructorStanding.position}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Nationality: ${constructorStanding.nationality}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Points: ${constructorStanding.points}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Wins: ${constructorStanding.wins}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
