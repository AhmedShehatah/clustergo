import 'package:firebase_database/firebase_database.dart';
import '../models/ride_intent.dart';

class FirebaseManager {
  static final FirebaseManager _instance = FirebaseManager._internal();
  factory FirebaseManager() => _instance;
  FirebaseManager._internal();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Reference to rides node in Firebase
  DatabaseReference get ridesRef => _database.child('rides');

  // Create a new ride intent
  Future<String> createRide(RideIntent ride) async {
    try {
      // Generate a unique key for the ride
      final newRideRef = ridesRef.push();
      final rideId = newRideRef.key!;

      // Create a new ride with the generated ID
      final rideWithId = RideIntent(
        id: rideId,
        userName: ride.userName,
        pickup: ride.pickup,
        destination: ride.destination,
        time: ride.time,
        availableSeats: ride.availableSeats,
      );

      // Save to Firebase
      await newRideRef.set(rideWithId.toMap());
      return rideId;
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  // Listen to all rides in real-time
  Stream<List<RideIntent>> getRidesStream() {
    return ridesRef.onValue.map((event) {
      final List<RideIntent> rides = [];

      if (event.snapshot.value != null) {
        final ridesMap = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map,
        );

        ridesMap.forEach((key, value) {
          try {
            final rideMap = Map<dynamic, dynamic>.from(value as Map);
            rides.add(RideIntent.fromMap(rideMap, key));
          } catch (e) {
            print('Error parsing ride $key: $e');
          }
        });

        // Sort rides by time (earliest first)
        rides.sort((a, b) => a.time.compareTo(b.time));
      }

      return rides;
    });
  }

  // Get a single ride by ID
  Future<RideIntent?> getRide(String rideId) async {
    try {
      final snapshot = await ridesRef.child(rideId).get();
      if (snapshot.exists) {
        final rideMap = Map<dynamic, dynamic>.from(snapshot.value as Map);
        return RideIntent.fromMap(rideMap, rideId);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get ride: $e');
    }
  }

  // Update a ride
  Future<void> updateRide(String rideId, Map<String, dynamic> updates) async {
    try {
      await ridesRef.child(rideId).update(updates);
    } catch (e) {
      throw Exception('Failed to update ride: $e');
    }
  }

  // Delete a ride
  Future<void> deleteRide(String rideId) async {
    try {
      await ridesRef.child(rideId).remove();
    } catch (e) {
      throw Exception('Failed to delete ride: $e');
    }
  }

  // Update available seats
  Future<void> updateAvailableSeats(String rideId, int newSeats) async {
    try {
      await ridesRef.child(rideId).update({'availableSeats': newSeats});
    } catch (e) {
      throw Exception('Failed to update seats: $e');
    }
  }
}
