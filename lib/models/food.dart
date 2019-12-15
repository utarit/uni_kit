class Food {
  final List<dynamic> lunch;
  final List<dynamic> dinner;

  Food({this.lunch, this.dinner});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      lunch: json['ogle'],
      dinner: json['aksam'],
    );
  }
}
