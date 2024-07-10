// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/models/weather_data.dart';

class ApiService {
  final String apiKey = "4df7536c4c1dea3a9f4f994f9fd31e0f";
  final String apiUrl = "https://api.openweathermap.org/data/2.5/weather";
  final double latitude = 27.1592; // Latitude for India
  final double longitude = 78.3957; // Longitude for India

  Future<WeatherDataModel> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse('$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return WeatherDataModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  Future<WeatherDataModel> fetchCityData(String cityName) async {
    final response = await http.get(
      Uri.parse('$apiUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return WeatherDataModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
