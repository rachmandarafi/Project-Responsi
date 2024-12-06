import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    final data = json.decode(response.body);
    return data['categories'];
  }

  static Future<List<dynamic>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));
    final data = json.decode(response.body);
    return data['meals'];
  }

  static Future<Map<String, dynamic>> fetchMealDetails(String mealId) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId'));
    final data = json.decode(response.body);
    return data['meals'][0];
  }
}
