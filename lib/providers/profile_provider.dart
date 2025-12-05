import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../services/api_service.dart';

class ProfileProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _error;

  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch user profile
  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userProfile = await _apiService.getUserProfile();
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      _userProfile = null;
      notifyListeners();
    }
  }

  // Retry fetching profile
  Future<void> retry() async {
    await fetchUserProfile();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
