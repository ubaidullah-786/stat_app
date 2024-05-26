import 'package:flutter/material.dart';
import 'package:stats_app/models/race_result_model.dart';

class RaceResultListItem extends StatelessWidget {
  final RaceResult raceResult;
  final VoidCallback onTap;

  const RaceResultListItem({
    required this.raceResult,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Row(
        children: [
          Text(
            raceResult.position,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              raceResult.driverName,
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
        raceResult.constructorName,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.orange,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}