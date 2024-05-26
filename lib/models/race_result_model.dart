class RaceResult {
  final String position;
  final String driverName;
  final String constructorName;
  final String time;
  final String grid;
  final dynamic fastestLap;
  final bool isFinished;
  final String eventName; // Added field for event name

  RaceResult({
    required this.position,
    required this.driverName,
    required this.constructorName,
    required this.time,
    required this.grid,
    required this.fastestLap,
    required this.isFinished,
    required this.eventName, // Added event name parameter
  });

  factory RaceResult.fromJson(Map<String, dynamic> json) {
    return RaceResult(
      position: json['position'] as String,
      driverName: '${json['Driver']['givenName']} ${json['Driver']['familyName']}',
      constructorName: json['Constructor']['name'] as String,
      time: json['Time'] != null ? json['Time']['time'] as String : 'N/A',
      grid: json['grid'] != null ? json['grid'].toString() : 'N/A',
      fastestLap: json['FastestLap'],
      isFinished: json['status'] == 'Finished',
      eventName: json['raceName'] as String, // Assuming event name is provided in JSON as 'raceName'
    );
  }
}
