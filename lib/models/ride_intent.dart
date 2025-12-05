class RideIntent {
  final String id;
  final String userName;
  final String pickup;
  final String destination;
  final DateTime time;
  final int availableSeats;

  RideIntent({
    required this.id,
    required this.userName,
    required this.pickup,
    required this.destination,
    required this.time,
    required this.availableSeats,
  });

  // Convert RideIntent to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'pickup': pickup,
      'destination': destination,
      'time': time.toIso8601String(),
      'availableSeats': availableSeats,
    };
  }

  // Create RideIntent from Firebase Map
  factory RideIntent.fromMap(Map<dynamic, dynamic> map, String id) {
    return RideIntent(
      id: id,
      userName: map['userName'] ?? '',
      pickup: map['pickup'] ?? '',
      destination: map['destination'] ?? '',
      time: DateTime.parse(map['time']),
      availableSeats: map['availableSeats'] ?? 0,
    );
  }
}
