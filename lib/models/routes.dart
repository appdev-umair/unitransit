// Route Class
class Routes {
  final String id;
  final String routeName;
  final String startLocation;
  final String endLocation;
  final String timings;

  Routes({
    required this.id,
    required this.routeName,
    required this.startLocation,
    required this.endLocation,
    required this.timings,
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      id: json['id'].toString(),
      routeName: json['routeName'],
      startLocation: json['startLocation'],
      endLocation: json['endLocation'],
      timings: json['timings'],
    );
  }
}
