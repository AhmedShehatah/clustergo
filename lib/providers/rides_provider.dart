import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/ride_intent.dart';
import '../services/rides_service.dart';

class RidesProvider with ChangeNotifier {
  final RidesService _ridesService = RidesService();

  List<RideIntent> _rides = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<List<RideIntent>>? _ridesSubscription;

  List<RideIntent> get rides => _rides;
  bool get isLoading => _isLoading;
  String? get error => _error;

  RidesProvider() {
    // Start listening to rides when provider is created
    listenToRides();
  }

  // Listen to real-time updates from Firebase
  void listenToRides() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _ridesSubscription = _ridesService.getRidesStream().listen(
      (rides) {
        _rides = rides;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (error) {
        _error = 'Failed to load rides: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // Create a new ride
  Future<String?> createRide(RideIntent ride) async {
    try {
      final rideId = await _ridesService.createRide(ride);
      return rideId;
    } catch (e) {
      _error = 'Failed to create ride: $e';
      notifyListeners();
      return null;
    }
  }

  // Update a ride
  Future<bool> updateRide(String rideId, Map<String, dynamic> updates) async {
    try {
      await _ridesService.updateRide(rideId, updates);
      return true;
    } catch (e) {
      _error = 'Failed to update ride: $e';
      notifyListeners();
      return false;
    }
  }

  // Delete a ride
  Future<bool> deleteRide(String rideId) async {
    try {
      await _ridesService.deleteRide(rideId);
      return true;
    } catch (e) {
      _error = 'Failed to delete ride: $e';
      notifyListeners();
      return false;
    }
  }

  // Update available seats
  Future<bool> updateAvailableSeats(String rideId, int newSeats) async {
    try {
      await _ridesService.updateAvailableSeats(rideId, newSeats);
      return true;
    } catch (e) {
      _error = 'Failed to update seats: $e';
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _ridesSubscription?.cancel();
    super.dispose();
  }
}
