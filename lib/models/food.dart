import 'package:uni_kit/utils/common_functions.dart';

const List<String> foodEmoji = [
  "🍲",
  "🍛",
  "🍚",
  "🍮",
  "🌿"
];

class Food {
  final List<String> lunch;
  final List<String> dinner;

  Food({this.lunch, this.dinner});

  factory Food.fromJson(Map<String, dynamic> json) {
    List<String> lunch = [];
    List<String> dinner = [];
    int lunchLen = json["ogle"].length;
    int dinnerLen = json["aksam"].length;
    for(int i = 0; i < lunchLen; i++){
      lunch.add("${foodEmoji[i]} " + capitalizeFirstLetter(json["ogle"][i]["name"]));
    }

    for(int i = 0; i < dinnerLen; i++){
      dinner.add("${foodEmoji[i]} " + capitalizeFirstLetter(json["aksam"][i]["name"]));
    }
    lunch.last = lunch.last.replaceAll("(vejetaryen)", "");
    dinner.last = dinner.last.replaceAll("(vejetaryen)", "");
    return Food(
      lunch: lunch,
      dinner: dinner,
    );
  }
}
