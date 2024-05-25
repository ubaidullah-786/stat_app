class DriverStanding {
  final String position;
  final String driverName;
  final String constructorName;
  final String points;
  final String wikipedia; // Add wikipedia field

  DriverStanding({
    required this.position,
    required this.driverName,
    required this.constructorName,
    required this.points,
    required this.wikipedia, // Initialize wikipedia field
  });

  factory DriverStanding.fromJson(Map<String, dynamic> json) {
    return DriverStanding(
      position: json['position'],
      driverName: json['Driver']['givenName'] + ' ' + json['Driver']['familyName'],
      constructorName: json['Constructors'][0]['name'],
      points: json['points'],
      wikipedia: json['Driver']['url'], // Extract wikipedia URL from JSON
    );
  }
}
