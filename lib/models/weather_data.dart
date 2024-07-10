// weather_data.dart

class WeatherDataModel {
  final String description;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String icon;
  final double rain;

  WeatherDataModel({
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.rain
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      icon: json['weather'][0]['icon'],
      rain: json['rain'] != null ? json['rain']['1h'] ?? 0.0 : 0.0,
    );
  }
}
