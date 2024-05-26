// models/constructor_standing_model.dart
class ConstructorStanding {
  final String position;
  final String constructorName;
  final String points;
  final String nationality;
  final int wins;

  ConstructorStanding({
    required this.position,
    required this.constructorName,
    required this.points,
    required this.nationality,
    required this.wins,
  });

  factory ConstructorStanding.fromJson(Map<String, dynamic> json) {
    return ConstructorStanding(
      position: json['position'],
      constructorName: json['Constructor']['name'],
      points: json['points'],
      nationality: json['Constructor']['nationality'],
      wins: json['wins'] is int ? json['wins'] : int.tryParse(json['wins']) ?? 0,
    );
  }
}
