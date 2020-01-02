import 'package:uni_kit/features/dashboard/data/models/food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodProvider {
  Food food;

  Future<Food> getFoodData() async {
    final response =
        await http.get('https://kafeterya.metu.edu.tr/service.php');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      dynamic body = json.decode(utf8.decode(response.bodyBytes));
      if (body != null) {
        return Food.fromJson(body);
      }
    }
    return null;
  }
}
