import '../models/ride_intent.dart';

List<RideIntent> getSampleRides() {
  return [
    RideIntent(
      id: '1',
      userName: 'Nada Nabil',
      pickup: 'Main Gate',
      destination: 'Nasr City',
      time: DateTime.now().add(Duration(minutes: 15)),
      availableSeats: 2,
    ),
    RideIntent(
      id: '2',
      userName: 'Sara ALi',
      pickup: 'Engineering Building',
      destination: 'Heliopolis',
      time: DateTime.now().add(Duration(minutes: 30)),
      availableSeats: 3,
    ),
    RideIntent(
      id: '3',
      userName: 'Rghda shehata',
      pickup: 'Library',
      destination: 'Maadi',
      time: DateTime.now().add(Duration(hours: 1)),
      availableSeats: 1,
    ),
    RideIntent(
      id: '4',
      userName: 'Tasneem Muhammed',
      pickup: 'Main Gate',
      destination: 'Downtown',
      time: DateTime.now().add(Duration(hours: 1, minutes: 20)),
      availableSeats: 2,
    ),
    RideIntent(
      id: '5',
      userName: 'Youssef Ibrahim',
      pickup: 'Sports Complex',
      destination: '6th October',
      time: DateTime.now().add(Duration(hours: 2)),
      availableSeats: 4,
    ),
  ];
}