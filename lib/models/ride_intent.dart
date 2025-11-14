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
}