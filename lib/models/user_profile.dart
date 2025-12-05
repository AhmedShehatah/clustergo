import 'package:intl/intl.dart';
import 'preference.dart';

class UserProfile {
  final String name;
  final String email;
  final String university;
  final String memberSince;
  final int totalRides;
  final List<Preference> preferences;

  UserProfile({
    required this.name,
    required this.email,
    required this.university,
    required this.memberSince,
    required this.totalRides,
    required this.preferences,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    List<Preference> preferencesList = [];
    if (json['preferences'] != null) {
      preferencesList = (json['preferences'] as List)
          .map((pref) => Preference.fromJson(pref))
          .toList();
    }

    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      university: json['university'] ?? '',
      memberSince: json['member_since'] ?? '',
      totalRides: json['total_rides'] ?? 0,
      preferences: preferencesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'university': university,
      'member_since': memberSince,
      'total_rides': totalRides,
      'preferences': preferences.map((p) => p.toJson()).toList(),
    };
  }

  // Get initials from name (e.g., "Rghda Salah" -> "RS")
  String get initials {
    if (name.isEmpty) return '??';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '??';
  }

  // Format member_since date (e.g., "2003-9-8" -> "8 September 2003")
  String get formattedMemberSince {
    try {
      // Parse the date string (format: "2003-9-8")
      final dateParts = memberSince.split('-');
      if (dateParts.length == 3) {
        final year = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final day = int.parse(dateParts[2]);

        final date = DateTime(year, month, day);
        // Format as "8 September 2003"
        return DateFormat('d MMMM yyyy').format(date);
      }
      return memberSince;
    } catch (e) {
      return memberSince;
    }
  }

  // Format total rides display
  String get formattedTotalRides {
    return '$totalRides ${totalRides == 1 ? 'ride' : 'rides'}';
  }
}
