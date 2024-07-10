import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_data.dart';
import 'package:my_weather_app/services/api_service.dart';
import 'package:my_weather_app/view/constant.dart';
import 'package:my_weather_app/view/reusable_button.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  ApiService apiService=ApiService();
  final TextEditingController _controller = TextEditingController();
  late Future<WeatherDataModel> futureWeatherData;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize with default city (e.g., Firozabad)
    futureWeatherData = ApiService().fetchCityData("Firozabad");
  }

  void _searchWeather() {
    setState(() {
      _isSearching = true;
      futureWeatherData = ApiService().fetchCityData(_controller.text);
    });
  }
  Color getBackgroundColor(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Colors.blue;
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return Colors.grey;
      case 'shower rain':
      case 'rain':
        return Colors.blueGrey;
      case 'thunderstorm':
        return Colors.deepPurple;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'mist':
        return Colors.teal;
      default:
        return Colors.white70;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.blueAccent,

      body: SingleChildScrollView(child:  Padding(
        padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                _searchWeather();
              },
              decoration: InputDecoration(
                labelText: 'Enter city name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter city name',
                fillColor: Colors.white.withOpacity(.5),filled: true,
                hintStyle: TextStyle(color: Colors.white.withOpacity(.5)
                ),

                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(30)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(30)
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ReusableButton(title: "Search", voidCallback: _searchWeather),
            SizedBox(height: MediaQuery.of(context).size.height*.07),
            FutureBuilder<WeatherDataModel>(
              future: futureWeatherData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: Colors.white,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  WeatherDataModel data = snapshot.data!;
                  return Container( height: MediaQuery.of(context).size.height*.45,
                    width: MediaQuery.of(context).size.width*.8,
                    decoration: BoxDecoration(
                        color: getBackgroundColor(data.description),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,spreadRadius: 10,
                              color: getBackgroundColor(data.description),
                              blurStyle: BlurStyle.outer
                          )
                        ]),
                    child: Column( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.text.toString(),style: cityNameTextStyle,),
                        Image.network(
                          'http://openweathermap.org/img/wn/${data.icon}@2x.png',
                          scale: 1.0,
                        ),
                        Text(
                          'Description: ${data.description}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Temperature: ${data.temperature}°C',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Feels Like: ${data.feelsLike}°C',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Humidity: ${data.humidity}%',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Wind Speed: ${data.windSpeed} m/s',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),)
    );
  }
}
