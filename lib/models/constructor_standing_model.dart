class ConstructorStanding {
  final String position;
  final String constructorName;
  final String points;

  ConstructorStanding({
    required this.position,
    required this.constructorName,
    required this.points,
  });

  factory ConstructorStanding.fromJson(Map<String, dynamic> json) {
    return ConstructorStanding(
      position: json['position'],
      constructorName: json['Constructor']['name'],
      points: json['points'],
    );
  }
}
