class Preference {
  final String type;
  final bool allowed;

  Preference({required this.type, required this.allowed});

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      type: json['type'] ?? '',
      allowed: json['allowed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'allowed': allowed};
  }

  // Get display label for preference type
  String get displayLabel {
    switch (type.toLowerCase()) {
      case 'music':
        return 'Music allowed';
      case 'talking':
        return 'Talking allowed';
      case 'ac':
        return 'AC preferred';
      default:
        return type;
    }
  }
}
