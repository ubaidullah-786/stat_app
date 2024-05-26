// widgets/constructor_standing_list_item.dart
import 'package:flutter/material.dart';
import 'package:stats_app/models/constructor_standing_model.dart';
import 'package:stats_app/screens/constructor_details.dart';

class ConstructorStandingListItem extends StatelessWidget {
  final ConstructorStanding constructorStanding;

  const ConstructorStandingListItem({required this.constructorStanding, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Row(
        children: [
          Text(
            constructorStanding.position,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              constructorStanding.constructorName,
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
        '${constructorStanding.points} PTS',
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.orange,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConstructorDetails(constructorStanding: constructorStanding),
          ),
        );
      },
    );
  }
}
