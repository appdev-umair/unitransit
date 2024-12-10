// Bus Class
class Bus {
  final String id;
  final String busNumber;
  final String plateNumber;
  final String type;
  final bool isOperational;

  Bus({
    required this.id,
    required this.busNumber,
    required this.plateNumber,
    required this.type,
    required this.isOperational,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id']?.toString() ?? 'N/A',
      busNumber: json['busNumber'] ?? 'Unknown Bus Number',
      plateNumber: json['plateNumber'] ?? 'Unknown Plate Number',
      type: json['type'] ?? 'Unknown Type',
      isOperational: json['isOperational'] ?? false,
    );
  }
}
